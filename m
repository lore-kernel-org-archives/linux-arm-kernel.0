From: kim.phillips@arm.com (Kim Phillips)
Date: Wed, 9 May 2018 19:02:47 -0500
Subject: [PATCH] drivers/perf: arm-ccn: stop spamming dmesg in event_init
In-Reply-To: <20180509161120.ilnukvismwfb452g@lakrids.cambridge.arm.com>
References: <20180504104117.8086-1-mark.rutland@arm.com>
 <20180508184050.75c60b82ba538d0ecdeb2d78@arm.com>
 <1525882003.4199.55.camel@arm.com>
 <20180509161120.ilnukvismwfb452g@lakrids.cambridge.arm.com>
Message-ID: <20180509190247.b1cc37d59f3070b3b868988c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 9 May 2018 17:12:42 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> On Wed, May 09, 2018 at 05:06:43PM +0100, Pawel Moll wrote:
> > On Wed, 2018-05-09 at 00:40 +0100, Kim Phillips wrote:
> > > On Fri,  4 May 2018 11:41:17 +0100 Mark Rutland <mark.rutland@arm.com> wrote:
> > > 
> > > [adding Pawel, arm-ccn driver author]
> > 
> > We had this discussion way too many times for my liking. As I said
> > before - *I* will be fine with the debug messages in the CCN driver.
> 
> > > > The ARM CCN PMU driver uses dev_warn() to complain about parameters
> > > in
> > > > the user-provided perf_event_attr. This means that under normal
> > > > operation (e.g. a single invocation of the perf tool), dmesg may be
> > > > spammed with multiple messages.
> > 
> > Surely Mark, in his role as maintainer of drivers/perf/ (and a few
> > other locations), meant to use much more technical and emotion-free
> > subject, along the lines of "reduce a number of dmesg warnings at event
> > init".
> 
> True. I'll reword the above to:
> 
>   The ARM CCN PMU driver uses dev_warn() to complain about parameters in
>   the user-provided perf_event_attr. This means that under normal
>   operation (e.g. a single invocation of the perf tool), a number of
>   messages warnings may be logged to dmesg.

So from:

"...dmesg may be spammed with multiple messages."

to:

"...a number of messages warnings may be logged to dmesg."

Not sure what's *that* different between the two, but is the assumption
that "normal operation" - i.e., a single *valid* perf invocation -
still emits messages?  In which case, could the misunderstanding here
possibly be the following?:

Assuming I know what node is valid, I can still get messages:

$ dmesg -w &
$ sudo ./perf stat -e ccn/hnf_cache_miss,node=8/ find /usr > /dev/null
[626610.173759] arm-ccn e8000000.ccn: Can't exclude execution levels!
[626610.173790] arm-ccn e8000000.ccn: Can't exclude execution levels!

 Performance counter stats for 'system wide':

         1,096,602      ccn/hnf_cache_miss,node=8/                                   

       3.708314082 seconds time elapsed

But the driver is still technically correct in that it WARNs (not
invisibly DEBUGs) it's users about the EL problem.  In order to not
exclude the default execution levels, we postpend 'hku' to the event,
so now the EL messages are gone:

$ sudo ./perf stat -e ccn/hnf_cache_miss,node=8/hku find /usr > /dev/null

 Performance counter stats for 'system wide':

         1,086,521      ccn/hnf_cache_miss,node=8/hku                                   

       3.699726648 seconds time elapsed

What's important to keep the user warned about with arm-ccn is these
types of messages:

$ sudo ./perf stat -e ccn/hnf_cache_miss,node=1/hku find /usr > /dev/null
[626675.574828] arm-ccn e8000000.ccn: Invalid type 0x4 for node 1!
[626675.574841] arm-ccn e8000000.ccn: Invalid type 0x4 for node 1!

 Performance counter stats for 'system wide':

   <not supported>      ccn/hnf_cache_miss,node=1/                                   

       3.686169559 seconds time elapsed

See?  Now the user is pointed directly at the problem.

I've even enhanced the tool to help identify to the user the event with
an unsupported sampling error (commit 114bc191c370 "perf evsel: Say
which PMU Hardware event doesn't support sampling/overflow-interrupts").

BTW, the dmesg output above was only two lines per effective message:
That should be totally acceptable - it's only one line more than one
line per message.  Are you seeing much more than that?  If so, can we
see an example of an invocation that's completely unacceptable,
dmesg-volume-wise?

Thanks,

Kim
