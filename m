From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 31 Jan 2012 00:49:13 -0700 (MST)
Subject: [PATCH 1/2] ARM: OMAP3: PM: remove superfluous calls to
 pwrdm_clear_all_prev_pwrst()
In-Reply-To: <CAMQu2gyLgmbeqVevTbGazO3A+AkYPsPeWp9mp0eD_EwXs3SZ0w@mail.gmail.com>
References: <20120130093931.11027.31048.stgit@dusk>
 <20120130094312.11027.31050.stgit@dusk> <878vkopw2o.fsf@ti.com>
 <CAMQu2gxyY50Bno_R2v1x98-ND47CrVpZBq+wA3POXz2+7E7eEw@mail.gmail.com>
 <alpine.DEB.2.00.1201302359320.10061@utopia.booyaka.com>
 <CAMQu2gyACq7RFyfnyNddDg7xRbHTTqsgXwMq6Ng4WfLxaatvAw@mail.gmail.com>
 <alpine.DEB.2.00.1201310024510.10061@utopia.booyaka.com>
 <CAMQu2gyLgmbeqVevTbGazO3A+AkYPsPeWp9mp0eD_EwXs3SZ0w@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1201310044310.10061@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 31 Jan 2012, Shilimkar, Santosh wrote:

> A week back I was discussing with Benoit and Tony about having some
> infrastructure like "unused clocks" so that we can shutdown those
> modules, and if possible some power domains. That way they get
> removed at one single place and they the power domain calls
> need not iterate over the once which are no longer needed.

Sure, if you have some ideas, that sounds promising.  I'd assume the main 
performance issues would be related to global PRCM register reads, rather 
than raw CPU cycles.  So that's probably where it would make sense to 
focus the effort. 

We should also be able to optimize out a fair number of the powerdomain 
register reads if we cache them in the struct powerdomain.  The current 
powerstate and next powerstate seem to be hit a lot, and those should both 
be cacheable.  Will probably do some of this as part of the functional 
powerstate code.


- Paul
