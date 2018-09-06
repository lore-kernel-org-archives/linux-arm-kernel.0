From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 6 Sep 2018 18:01:24 +0200
Subject: [PATCH] mini2440 MMC correct write protect detection
In-Reply-To: <204cf57b-a4f2-76b9-766c-20905596ca4e@free.fr>
References: <85dac0df-2b75-9cc4-fde1-f62136974a1e@free.fr>
 <20180905174513.6w7z5jsc2e6ndntv@kozik-lap>
 <204cf57b-a4f2-76b9-766c-20905596ca4e@free.fr>
Message-ID: <20180906160124.626l5fgn2cn4veyq@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 05, 2018 at 09:45:15PM +0200, Cedric Roux wrote:
> On 09/05/2018 07:45 PM, Krzysztof Kozlowski wrote:
> > I looked at Mini2440 schematics found on the net and it looks like the
> > pin (just like CD) is active low. However I might be looking at wrong
> > schematics or missing some things.
> 
> I have the same schematics I think.
> But I have a real mini2440 and I am positively sure that WP
> is active high. CD is active low, yes.
> 
> Do you know someone that you trust that could confirm this?
> 
> > 
> > This is really an old code so I am just quite surprised that it was not
> > reported before. Not able to write to SD card (for example if it is
> > rootfs) should be spotted quite early.
> 
> I don't think anyone tried a recent kernel, that's why.
> And the mini2440 has been kind of replaced by the mini6410,
> I'm not sure it's still in production. Apart from me, I
> don't think anyone still uses it. If someone does, I
> heavily doubt that person will try to boot a 4.something
> kernel on it.
> 
> In the 2.6.32.63 kernel it's all different.
> 
> We have s3cmci_get_ro in drivers/mmc/host/s3cmci.c
> that calls s3c2410_gpio_getpin in arch/arm/plat-s3c24xx/gpio.c
> that returns the WP bit as is read from the GPIO.
> s3cmci_get_ro will return > 0 if the bit is set and
> wprotect_invert is not set. For mini2440, wprotect_invert
> is not set (actually it does not seem to be set anywhere
> in the kernel tree, is it used at all in 2.6.32.63?). So
> it's returned as is. Getting 1 from GPIO means Read Only.
> 
> Then we have s3cmci_card_present, also in drivers/mmc/host/s3cmci.c,
> that reads the CD bit from the GPIO, but take the opposite value
> and then returns the opposite of the result if detect_invert
> is 1. For mini2440 it's not 1, but 0. So we return the opposite
> of the CD bit read from the GPIO, which means active low.
> 
> I'm not an electronic professional so I don't know how to interpret
> the schematics. My experiment with my mini2440 says that:
> - no card:         WP bit = 1, CD bit = 1
> - card read/write: WP bit = 0, CD bit = 0
> - card read only:  WP bit = 1, CD bit = 0
> By "WP bit" I mean the value read from GPH8.
> By "CD bit" I mean the value read from GPG8.
> 
> So I don't know what to do. If you don't trust me and you know
> no one that you trust that would confirm my findings, then it's
> game over.
> 
> I can do things that you ask me to do to prove my claims.
> 
> I can provide a simple userland program to be run on a mini2440
> that demonstrates this as well (open /dev/mem, mmap 0x56000000,
> reads GPG and GPH and prints the values).

The patch was not patchwork compatible:
    Applying patch #10587863 using 'git am -s'
    Description: mini2440 MMC correct write protect detection
    Applying: mini2440 MMC correct write protect detection
    error: arm/mach-s3c24xx/mach-mini2440.c: does not exist in index

git-am by default expects -p1.

The preferred and easiest way to generate patches is to use git for your
work and then just:
    $ git format-patch -1
    $ scripts/get_maintainer 000*
    $ git send-email --to ........  000*

(the last commands can be even squashed into one but that is just
optimization).

If you do not use git, please pay attention to generate proper
applicable patches.

Best regards,
Krzysztof
