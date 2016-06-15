From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 15 Jun 2016 20:13:52 +0100
Subject: kexec failures with DEBUG_RODATA
In-Reply-To: <20160615075508.GB21202@dhcppc6>
References: <20160614175920.GD1041@n2100.armlinux.org.uk>
 <20160615075508.GB21202@dhcppc6>
Message-ID: <20160615191352.GG1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2016 at 01:25:08PM +0530, Pratyush Anand wrote:
> Sure, having a header information would be handy to do it. Other alternative
> could be that we define "HAVE_LIBZ" and then we can have something like
> kexec-Image-arm.c which handles plane Image.  We can also have something like
> get_zlib_decompressed_length() which can give us exact length we need for kernel
> and then we can place initrd accordingly in zImage_arm_load().

I really don't want to do that.  There are things that the decompressor
does which make it easier to deal with the zImage than the Image.

> I see at least another issue clearly in ARM kernel code with CONFIG_DEBUG_RODATA
> enabled.  When CONFIG_DEBUG_RODATA is enabled, we can not write text area.
> kexec_start_address has been defined in relocate_kernel.S as a text area.
> machine_kexec() writes at kexec_start_address with image->start. Similarly there
> would be issues for overwriting of kexec_indirection_page, kexec_mach_type and
> kexec_boot_atags. If arm mmu mapping configures text pages as RO, then we should
> see an abort as soon as we do these writes.

That's not a problem, because set_kernel_text_rw() is called immediately
prior to writing, which has the effect of allowing these writes.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
