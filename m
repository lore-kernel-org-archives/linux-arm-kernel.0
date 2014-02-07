From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 7 Feb 2014 13:13:47 -0500
Subject: [PATCH] i2c: mv64xxx: Fix locked bus when offload is selected
 but not used on a message
In-Reply-To: <7h7g96bxqm.fsf@paris.lan>
References: <1391770588-1344-1-git-send-email-gregory.clement@free-electrons.com>
 <20140207150958.GY8533@titan.lakedaemon.net>
 <7h7g96bxqm.fsf@paris.lan>
Message-ID: <20140207181347.GF8533@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 07, 2014 at 10:09:53AM -0800, Kevin Hilman wrote:
> Jason Cooper <jason@lakedaemon.net> writes:
> 
> > On Fri, Feb 07, 2014 at 11:55:54AM +0100, Gregory CLEMENT wrote:
> >> Offload can be used only on regular transactions and for 1 to byte
> >> transfers. In the other cases we switch back to usual work flow.
> >> 
> >> In this case we need to call mv64xxx_i2c_prepare_for_io() as this
> >> function is not used when we try to use offloading.
> >> 
> >> This commit adds this missing call when offloading have failed in the
> >> MV64XXX_I2C_ACTION_OFFLOAD_SEND_START case.
> >> 
> >> This fix the timeout seen when the the i2c driver try to access an
> >> address where the device is absent on the Armada XP bases board.
> >> 
> >> Cc: stable at vger.kernel.org # v3.12+
> >> Fixes: 930ab3d403ae (i2c: mv64xxx: Add I2C Transaction Generator support)
> >> 
> >> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> >> ---
> >>  drivers/i2c/busses/i2c-mv64xxx.c | 9 ++++++++-
> >>  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > I'd like to get a few tested-by's on this before this is pushed.  We've
> > had quite a bit of fixes this round :(  Please test both multi_v7 and
> > mvebu defconfigs.
> >
> > Kevin, I know you're busy with a lot more than us, but if you could
> > confirm that this fixes the bus hangs you reported, that would be great.
> 
> I applied this patch on top of next-20140207 and tested this on the
> armada-xp openblocks ax3, which is where I was seeing the I2C timeouts.
> 
> I confirm it fixes the timeouts I was seeing.
> 
> Tested-by: Kevin Hilman <khilman@linaro.org>

Thanks, Kevin!

thx,

Jason.
