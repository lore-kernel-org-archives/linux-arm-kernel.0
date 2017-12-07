From: will.deacon@arm.com (Will Deacon)
Date: Thu, 7 Dec 2017 13:38:13 +0000
Subject: [PATCH] perf: qcom_l2_pmu: don't allow guest access
In-Reply-To: <bc650fac-702c-e554-43ca-9cd3cfed9696@codeaurora.org>
References: <1512575733-923-1-git-send-email-nleeder@codeaurora.org>
 <20171206161149.ezlzzcuvxbot5tio@lakrids.cambridge.arm.com>
 <bc650fac-702c-e554-43ca-9cd3cfed9696@codeaurora.org>
Message-ID: <20171207133812.GG31900@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 06, 2017 at 04:19:24PM -0500, Leeder, Neil wrote:
> On 12/6/2017 11:11 AM, Mark Rutland wrote:
> > On Wed, Dec 06, 2017 at 10:55:33AM -0500, Neil Leeder wrote:
> >> Guests cannot access IMPDEF system registers, which are used
> >> by this driver. Disable the driver if it's running in a guest VM.
> >>
> >> Signed-off-by: Neil Leeder <nleeder@codeaurora.org>
> >> ---
> >>  drivers/perf/qcom_l2_pmu.c | 4 ++++
> >>  1 file changed, 4 insertions(+)
> > 
> > I'm a little confused by this. Why is this hypervisor providing a
> > QCOM8130 device to the guest that it cannot use?
> > 
> > Could you elaborate on what's going on?
> > 
> 
> While there's an argument that the guest shouldn't be loading the driver
> in the first place, we can't control everyone's guest configuration or what
> their hypervisor does.

Ok, but why is the hypervisor advertising a device that effectively doesn't
exist? Most drivers trust the firmware tables they are given, so this makes
it sound like we should start annotating all drivers for devices that we
don't expect to see in a guest with is_hyp_mode_available() checks.

That doesn't feel quite right to me.

Will
