From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sun, 26 Mar 2017 15:54:09 +0100
Subject: [PATCH 5/5] ALSA: AACI: Convert to use devm_ioremap_resource()
In-Reply-To: <1490539314-9681-6-git-send-email-leo.yan@linaro.org>
References: <1490539314-9681-1-git-send-email-leo.yan@linaro.org>
 <1490539314-9681-6-git-send-email-leo.yan@linaro.org>
Message-ID: <20170326145409.GP7909@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 26, 2017 at 10:41:54PM +0800, Leo Yan wrote:
> Convert to use devm_ioremap_resource() in probe function, otherwise it's
> missed to unremap this region if probe failed or rmmod module.

Again, wrong - just because there's nothing in the cleanup paths does
not mean it doesn't clean up.

static void aaci_free_card(struct snd_card *card)
{
        struct aaci *aaci = card->private_data;

        iounmap(aaci->base);
}

This unmaps the mapping you claim it fails to do so.  So, your patch
actually _creates_ bugs that were not there before.

NAK.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
