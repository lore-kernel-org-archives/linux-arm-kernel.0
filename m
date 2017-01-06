From: jbrunet@baylibre.com (Jerome Brunet)
Date: Fri, 06 Jan 2017 11:11:36 +0100
Subject: [PATCH net-next v4 0/4] Fix OdroidC2 Gigabit Tx link issue
In-Reply-To: <20170105232508.GU14217@n2100.armlinux.org.uk>
References: <1480348229-25672-1-git-send-email-jbrunet@baylibre.com>
 <049b1efc-3bad-92e0-45ef-0563dc5d81de@gmail.com>
 <20170105232508.GU14217@n2100.armlinux.org.uk>
Message-ID: <1483697496.28003.40.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-01-05 at 23:25 +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 28, 2016 at 09:54:28AM -0800, Florian Fainelli wrote:
> > 
> > If we start supporting generic "enable", "disable" type of
> > properties
> > with values that map directly to register definitions of the HW, we
> > leave too much room for these properties to be utilized to
> > implement a
> > specific policy, and this is not acceptable.
> 
> Another concern with this patch is that the existing phylib "set_eee"
> code is horribly buggy - it just translates the modes from userspace
> into the register value and writes them directly to the register with
> no validation.??So it's possible to set modes in the register that
> the
> hardware doesn't support, and have them advertised to the link
> partner.

Hi Russell,

The purpose of this patch is to provide a way to mark as broken a
particular eee mode. At first, it had nothing to do with "set_eee" but,
as Florian rightly pointed out, users shouldn't be able to re-enable a
broken mode.

At first, I was thinking about returning -ENOSUP if a broken mode was
requested. Then I noticed the behavior you just described: A user can
request anything of "set_eee", he won't necessarily get what he asked
but won't get an error either.

To avoid mixing different topic in a single patch, I kept the same
behavior, not returning an error, just silently discarding broken modes

I agree with you, we should probably validate a bit more what we asked
of the hardware in set_eee.

I wonder if we should return an error though. With the current
implementation, user space application could simply ask to activate
everything, excepting the kernel to sort it out and return an error
only if something horribly wrong happened. If we start returning an
error for unsupported modes, we could break things. I guess we should
just silently filter the requested modes.

> 
> I have a patch which fixes that, restricting (as we do elsewhere) the
> advert according to the EEE supported capabilities retrieved from the
> PCS

Could be interesting :)

>  - maybe the problem here is that the PCS doesn't support support
> EEE in 1000baseT mode?


It does, and that's kind of the problem. EEE in ON for 100Tx and 1000T
by default with this PHY. I have several platform with the same MAC-PHY 
combination. Only the OdroidC2 shows this particular issue with 1000T-
EEE

As explained in other mails in this thread. The problem does not come
from the MAC entering LPI. It actually comes from the link partner
entering LPI on the Rx path under significant Tx transfer. For some
reason, this completely mess up our PHY.

> 
> Out of interest, which PHY is used on this platform?

The PHY is the Realtek RTL8211F

> 
> On the SolidRun boards, they're using AR8035, and have suffered this
> occasional link drop problem.??What has been found is that it seems
> to
> be to do with the timing parameters, and it seemed to only be 1000bT
> that was affected.??I don't remember off hand exactly which or what
> the change was they made to stabilise it though, but I can probabily
> find out tomorrow.
> 

Since the same combination of MAC-PHY works well on other designs, it
is also my feeling that is has something to do with some timing
parameter, maybe related to this particular PCB.

While debugging this issue, we tried to play with all the parameters we
could think of but never found anything worth mentioning.

If you have any ideas, I'd be happy to try.

Jerome
