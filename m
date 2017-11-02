From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Nov 2017 17:10:19 +0000
Subject: [PATCH 3/3] ARM: early_printk: use printascii() rather than
 printch()
In-Reply-To: <SG2PR06MB116509D159F4E79D5A788DCE8A5C0@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <20171102000945.GT9463@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1711012249020.21665@knanqh.ubzr>
 <SG2PR06MB11655BDEF09BB62D268A29DD8A5C0@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <20171102112041.GW9463@n2100.armlinux.org.uk>
 <SG2PR06MB11653D39086B1F58497C9FE08A5C0@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <nycvar.YSQ.7.76.1711021044380.21665@knanqh.ubzr>
 <SG2PR06MB116563CB4F1B55160392AAC68A5C0@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <nycvar.YSQ.7.76.1711021132170.21665@knanqh.ubzr>
 <nycvar.YSQ.7.76.1711021157560.21665@knanqh.ubzr>
 <SG2PR06MB116509D159F4E79D5A788DCE8A5C0@SG2PR06MB1165.apcprd06.prod.outlook.com>
Message-ID: <20171102171018.GH9463@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 02, 2017 at 04:38:11PM +0000, Chris Brandt wrote:
> On Thursday, November 02, 2017 1, Nicolas Pitre wrote:
> > OK.. I wanted to get to the bottom of this. The gas documentation says:
> > 
> > |9.4.2.1 Instruction Set Syntax
> > |..............................
> > |
> > |Two slightly different syntaxes are supported for ARM and THUMB
> > |instructions.  The default, `divided', uses the old style where ARM and
> > |THUMB instructions had their own, separate syntaxes.  The new,
> > |`unified' syntax, which can be selected via the `.syntax' directive,
> > |and has the following main features:
> > |
> > |   * Immediate operands do not require a `#' prefix.
> 
> Well there you go!
> 
> We all have "gratuitously broken binutils"
> 
> ;)

Yes!

What reason could there be to drop the well established norm of
prefixing constants with "#" in ARM assembly, other than maybe
political pressure?

As I've already pointed out, we can see that this causes problems,
and what it means is that people now must test their changes with
Thumb2 support disabled in the kernel for there to be any valid
testing of assembly.  That basically means I can't trust anyone
elses testing of patches that contain assembly, because I don't
know what configuration they've tested.

This is very bad, and it's going to make it slower to get such
patches into the kernel.

That's an unintended side effect of what was probably thought to be
a trivial decision by the ARM ISA team, but it unfortunately has
wider effects than they could have imagined.

There is another solution to this: I augment the patch system with an
ARM assembly parser that detects this before it gets accepted,
rejecting patches that omit the # for constants.  However, that is
incomplete, because we now live in a world where ARM assembly gets
added to the kernel via many different git trees.

Basically, this change in the ARM syntax should never have been made.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
