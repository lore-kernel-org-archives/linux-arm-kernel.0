From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Nov 2016 13:29:05 +0000
Subject: TDA998x crash on HDLCD probe failure
In-Reply-To: <8281efe7-bac7-8e35-5784-e05cf0dc7eab@arm.com>
References: <8281efe7-bac7-8e35-5784-e05cf0dc7eab@arm.com>
Message-ID: <20161124132905.GG14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 24, 2016 at 01:18:39PM +0000, Robin Murphy wrote:
> Hi Liviu, Russell,
> 
> I'd been meaning to try digging into this if it hadn't gone away since I
> first noticed it, but I don't really have the time and it still happens
> with 4.9-rc and today's -next. Representative splat below, but in
> summary what happens is that if the HDLCD fails to probe, the TDA998x
> connector seems to get cleaned up twice, resulting in a NULL dereference
> the second time. I got as far as sketching out the following flow from a
> debug session (on the same 4.8-rc2 kernel), but I don't know nearly
> enough to tell which driver is at fault:
> 
> hdlcd_drm_bind
> -> drm_fbdev_cma_init (fails)
> ...
> -> drm_mode_config_cleanup
>    ...
>    -> drm_connector_cleanup
> -> component_unbind_all
>    ...
>    -> tda998x_unbind
>       -> drm_connector_cleanup (NULL connector)
> 
> It's easily reproduced on Juno by booting arm64 defconfig with
> CONFIG_CMA_SIZE_MBYTES=1 and a sufficiently large monitor connected to
> warrant a >1MB framebuffer.

It looks to me like a hdlcd bug.

The probe path operates in this order:

- allocates hdlcd - 1
- allocates drm device - 2
- drm_mode_config_init - 3
- hdlcd_load - 4
- binds all components - 5
- enables runtime PM - 6
- drm_vblank_init - 7
- drm_mode_config_reset - 8
- drm_kms_helper_poll_init - 9
- drm_fbdev_cma_init - 10
- drm_dev_register - 11

However, the cleanup operates in this order:
- drm_fbdev_cma_fini - undoes 10
- drm_kms_helper_poll_fini - undoes 9
- drm_mode_config_cleanup - undoes 3
- drm_vblank_cleanup - undoes 7
- pm_runtime_disable - undoes 6
- component_unbind_all - undoes 5
- drm_irq_uninstall - undoes 4
- of_reserved_mem_device_release - undoes other half of 4
- drm_dev_unref - undoes 2

Spot the step which is out of the correct order - drm_mode_config_cleanup()
is misplaced - it's reversing the actions of drm_mode_config_init(), not
drm_mode_config_reset().

So, drm_mode_config_cleanup() should be much later, after step 4 has
been undone, otherwise there are paths that leave various DRM objects
(created by drm_mode_create_standard_properties()) referenced, and
will cause problems exactly like you're seeing here.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
