From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Oct 2015 20:16:41 +0100
Subject: [PATCH v2 21/22] arm64: cpuinfo: Expose MIDR_EL1 and REVIDR_EL1
 to sysfs
In-Reply-To: <CAPvkgC31-gUmetN0S=t9yJ30M8=x7Y7prxO40tiEB=zJiUvwBg@mail.gmail.com>
References: <1444064531-25607-1-git-send-email-suzuki.poulose@arm.com>
 <1444064531-25607-22-git-send-email-suzuki.poulose@arm.com>
 <20151006090959.GO21513@n2100.arm.linux.org.uk>
 <CAPvkgC31-gUmetN0S=t9yJ30M8=x7Y7prxO40tiEB=zJiUvwBg@mail.gmail.com>
Message-ID: <20151006191641.GW21513@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 06, 2015 at 11:18:42AM +0100, Steve Capper wrote:
> On 6 October 2015 at 10:09, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Mon, Oct 05, 2015 at 06:02:10PM +0100, Suzuki K. Poulose wrote:
> >> +static int __init cpuinfo_regs_init(void)
> >> +{
> >> +     int cpu, ret;
> >> +
> >> +     for_each_present_cpu(cpu) {
> >> +             struct device *dev = get_cpu_device(cpu);
> >> +
> >> +             if (!dev)
> >> +                     return -1;
> >
> > NAK.  Go figure out why, I'm too lazy to tell you.
> 
> I will correct the return code to be -ENODEV.
> Was that the reasoning behind the NAK?

The reason behind the NAK was indeed returning -1 from a function where
a negative return code is a negative errno value.  I'm fed up with
telling people about this, and I put it down to laziness.  So, I've
decided I'm going to NAK such patches and let the author have the hard
work of working out why - hopefully learning something by doing so,
and hopefully remembering for next time. :)

-1 corresponds to -EPERM, which means "operation not permitted"
(and, if this gets returned to userspace, the user program executing
the syscall will most probably tell the user "operation not permitted"
as the reason for failure - which is rather daft when you think about
it.

I have my mail client setup to highlight with a red background on a
"\+.*return -1" regexp, which nicely lets me catch every one of those
in any patch I skim through.

This is about quality of implementation issue - and, tbh, if someone
can't spend the time to check what happens to the return value, and
then can't spend the time to look up a proper errno value, then what's
the chance the rest of the patch (or patch set) has had sufficient care
and attention paid to it?

I'm getting to the point where if I see a "return -1" I just stop
reviewing the rest of the patch set, especially if it's a large patch
set.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
