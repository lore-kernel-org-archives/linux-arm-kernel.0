From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 20 Oct 2015 15:17:36 +0100
Subject: [PATCH 0/5] Fix regression introduced by set_irq_flags() removal
In-Reply-To: <20151020160828.497fcc80@free-electrons.com>
References: <1445347435-2333-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20151020140427.GE3953@io.lakedaemon.net>
 <20151020160828.497fcc80@free-electrons.com>
Message-ID: <20151020141736.GX32532@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 20, 2015 at 04:08:28PM +0200, Thomas Petazzoni wrote:
> As discussed on IRC, another simpler (code line wise) solution is to
> simply clear the IRQ_NOAUTOEN flag in the irq-armada-370-xp, which
> brings us back to what set_irq_flags() was doing, without actually
> reverting Rob's patch.
> 
> However, relying on IRQ_NOAUTOEN being cleared doesn't seem like the
> right long term solution, which is why I implemented what I believe is
> a (hopefully) better long term solution.

However, this is rather worrying.  NOAUTOEN is supposed to avoid enabling
the interrupt when the interrupt is claimed.

If, as a result of Rob's patch, we now have a load of IRQs which are
marked with NOAUTOEN which weren't, that's quite a large regression -
possibly one which hasn't been properly found (not everyone tests -rc
kernels) and we may be better to revert Rob's patch to avoid lots of
breakge being reported when 4.3 is released.

I think Rob's patches need another review in light of this, to determine
how much breakage there is here, and a decision how to proceed made on
that basis.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
