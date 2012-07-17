From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 17 Jul 2012 15:31:29 -0600 (MDT)
Subject: [PATCHv4 7/8] ARM: OMAP: clockdomain: add support for preventing
 autodep delete
In-Reply-To: <1342536971.4672.82.camel@sokoban>
References: <1342189185-5306-1-git-send-email-t-kristo@ti.com>
 <1342189185-5306-8-git-send-email-t-kristo@ti.com> <5003F453.9020903@ti.com>
 <1342536971.4672.82.camel@sokoban>
Message-ID: <alpine.DEB.2.00.1207171508010.28834@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Tue, 17 Jul 2012, Tero Kristo wrote:

> The underlying issue still remains, we have errata i582 which doesn't
> have any workarounds in the kernel yet. We should probably resurrect
> something like this:
> 
> http://www.mail-archive.com/linux-omap at vger.kernel.org/msg38834.html
> 
> ... or just pull the part which adds the dynamic wakedep add / remove
> for the per domain when attempting per OFF.

Yep looks like Kevin had some comments on that patch that no one followed 
up on.  Guess we need to figure out who will have time to revise and 
update it.

A few comments on that patch.

1. Looks to me like the patch needs to be split into several smaller 
patches.  One patch should deal with the serial changes.  Another should 
deal with the pm34xx.c changes.

2. Looks like we also need a patch to run the McBSP2/3 sidetone 
loopback test.  Then the pm34xx.c test code would be something like:

if (omap_uart_test_erratum_i582() || omap_mcbsp_test_erratum_i582()) {
 pr_err("%s: erratum i582 encountered; applying workaround\n", __func__);
 .. etc.
}

3. When the erratum is encountered, shouldn't the code schedule a CORE OFF 
transition to occur at the earliest possible moment, rather than just 
emitting a message?

4. The bug is only a problem when the PER serial ports/McBSP sidetone 
devices are in use, right?  So if those devices aren't in use then we can 
defer the device tests until right before one of those devices is brought 
into use, no?

5. There needs to be a better way of determining if a device is affected 
by this than by testing uart->num.  Adding a hwmod dev_attr flag would be 
my first inclination.


- Paul
