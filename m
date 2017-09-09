From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 9 Sep 2017 10:06:37 +0100
Subject: [PATCH] scripts: make extract-vmlinux support armel/armhf
In-Reply-To: <CAEQ9gEk6iGFY0hx36QbQHywKbttWTJdQxZzpOKULCgFLvS9TOw@mail.gmail.com>
References: <20170831153631.31026-1-rogershimizu@gmail.com>
 <20170831154941.GS20805@n2100.armlinux.org.uk>
 <CAEQ9gEmBv-fb2MbedSzs+dWtrq-ChXwiMrisyofZ7zfu+jADYA@mail.gmail.com>
 <20170831161957.GU20805@n2100.armlinux.org.uk>
 <20170831174318.GM6008@atomide.com>
 <20170901231654.GY20805@n2100.armlinux.org.uk>
 <CAEQ9gEk6iGFY0hx36QbQHywKbttWTJdQxZzpOKULCgFLvS9TOw@mail.gmail.com>
Message-ID: <20170909090637.GA20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 09, 2017 at 04:33:55PM +0900, Roger Shimizu wrote:
> On Sat, Sep 2, 2017 at 8:16 AM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > On Thu, Aug 31, 2017 at 10:43:19AM -0700, Tony Lindgren wrote:
> >> I think the use case is to get the booted kernel size from zImage
> >> to avoid overwriting dts or initramfs. Don't we already have that
> >> at the end of zImage somewhere for kexec?
> >
> > We do, but finding where that is is difficult if a DTB has been appended
> > as it's right at the end of the compressed data.  kexec doesn't use it,
> > it just assumes there's a 5x expansion of the kernel compressed image.
> 
> My patch already take the appended DTB blob part into consideration.
> It uses "unxz --single-stream" instead of "unxz" to extract, so unxz
> just ignore the DTB.

Sorry, I wasn't talking about the patch here.

The whole point of _this_ method of replying, where the relevant context
of the message being replied to is left and the reply is placed directly
beneath the paragraph to which the reply is relevant is to make clear
_what_ is being replied to.

My comments above are directly beneath a comment from Tony Lindgren asking
about the size field, which is appended after the compressed kernel image
data.  My reply was to Tony on that point alone, and why we aren't using
that for kexec-tools.

kexec-tools used to assume too small a size for the expansion of the
kernel image, and that has been changed.

I'm afraid that I still haven't got around to looking at _any_ of the
URLs you've provided so I'm still in the dark about (a) why this is
needed and (b) why it's acceptable for this script to output a binary
blob for ARM rather than an ELF file that it guarantees today.  It's
annoying that elinks' SSL implementation is buggy and causes connections
to certain SSL sites to fail, but alas that's the inconvenience that
buggy software causes.

Until I'm able to see some reasoning, I can't begin to consider this
patch.

Moreover, I'm not convinced by any of your arguments about why it's
acceptable to defeat the check for the ELF object _for all users_ of
this script.  What if some other architecture has multiple compressed
objects in their image and the "vmlinux" is not the first.  Your
argument seems to be "they should use a different script", yet you
are the one changing the script from outputting the first compressed
ELF object to merely producing the first compressed image.  "vmlinux"
is the name of the ELF kernel image, and the script is called
"extract-vmlinux" so this is obviously the right script which should
be extracting the correct compressed ELF object.

Hence, I don't buy your reasoning that in such a situation, another
architecture's use of this script should use some other script because
your changes fix it for ARM but cause a regression elsewhere.

The way we work on the kernel, if a change causes a user visible
regression, then the change was wrong and an alternative solution
needs to be sought.

I percieve the risk of this patch causing a regression on other
architectures to be high because it gratuitously changes functionality
of the script which didn't have to be there if all we cared about was
extracting the first image.  Hence, it must have been added because
there is a need for it.

So far, nothing has been said that lowers that risk.

It's not up to me to search around to try and evaluate risk - it's
my responsibility to ask the question (I already did) and it's the
submitter's responsibility to show that it's likely safe.

Thus far, the reasoning seems to be purely "several people are having
a problem with this script on ARM, here's a patch that fixes it for
ARM but might break existing users, but we don't care about existing
users."  That makes me even more wary.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
