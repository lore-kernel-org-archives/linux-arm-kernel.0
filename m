From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 31 Mar 2012 17:53:02 +0100
Subject: [PATCH] ARM: amba: adapt to regulator probe deferral change
In-Reply-To: <20120331143539.GB26661@n2100.arm.linux.org.uk>
References: <1333115737-1654-1-git-send-email-shawn.guo@linaro.org>
 <20120330180134.GJ22981@n2100.arm.linux.org.uk>
 <20120331134215.GA5012@opensource.wolfsonmicro.com>
 <20120331143539.GB26661@n2100.arm.linux.org.uk>
Message-ID: <20120331165301.GC5012@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 31, 2012 at 03:35:39PM +0100, Russell King - ARM Linux wrote:
> On Sat, Mar 31, 2012 at 02:42:15PM +0100, Mark Brown wrote:

> > We need to change the AMBA bus so it does something better than what it
> > does now and work out a good way to roll this out.  The more I think
> > about this the less convinced I am that AMBA should have regualtor
> > support in the bus itself at all.

> How else does it power up the peripheral to read out the IDs?  You can't
> bind a driver until you've read the ID, which implies that the bus layer
> needs to have regulator support to turn the power on.

Like I said further down my mail it seems like any systems which do have
individual regulators for the AMBA devices probably ought to be managing
this via power domain code rather than by going direct to the regulator
API.  If actual regulators are required the power domain code for the
platform would be responsible for doing that rather than AMBA itself but
for most SoCs it's likely to not go through the regulator API if there's
any sort of gating support at all.

It's possible I'm misreading this as I'm not terribly familiar with AMBA
but based on what I do know plus the changelog for the patch introducing
it and the one driver that manages vcore at runtime it really does look
like what's going on.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120331/665d48b5/attachment-0001.sig>
