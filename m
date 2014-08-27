From: punit.agrawal@arm.com (Punit Agrawal)
Date: Wed, 27 Aug 2014 18:35:07 +0100
Subject: [PATCH 5/6] arm64: Port SWP/SWPB emulation support from arm
In-Reply-To: <20140826135623.GR23445@arm.com> (Will Deacon's message of "Tue,
 26 Aug 2014 14:56:23 +0100")
References: <1409048930-21598-1-git-send-email-punit.agrawal@arm.com>
 <7433994.DUuXUlazW0@wuerfel> <20140826122542.GL23445@arm.com>
 <5600657.GfhaIFRH9n@wuerfel> <20140826135623.GR23445@arm.com>
Message-ID: <9hh4mwxesz8.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will Deacon <will.deacon@arm.com> writes:

> On Tue, Aug 26, 2014 at 02:26:58PM +0100, Arnd Bergmann wrote:
>> On Tuesday 26 August 2014 13:25:43 Will Deacon wrote:
>> > On Tue, Aug 26, 2014 at 12:32:23PM +0100, Arnd Bergmann wrote:
>> > > On Tuesday 26 August 2014 11:28:49 Punit Agrawal wrote:
>> > > > 
>> > > > This patch ports the alternative solution to emulate the SWP and SWPB
>> > > > instructions using LDXR/STXR sequences from the arm port to
>> > > > arm64. Additionaly, the patch also proivdes support to log the
>> > > > emulation statistics via debugfs.
>> > > 
>> > > I'm not sure that putting this into debugfs is a good idea in this
>> > > case: while in general that is considered a good place for this
>> > > kind of debugging information, we already have a precedent on arm32
>> > > for using procfs, and I see no reason to introduce an incompatible
>> > > interface for arm64.
>> > > 
>> > > You also add an interface for disabling the feature at runtime,
>> > > which we don't have on arm32, but that interface is not available
>> > > if debugfs is disabled or not mounted. Maybe a sysctl would be
>> > > more appropriate? That one could also be shared with arm32.
>> > 
>> > One advantage of using debugfs is that it provides a place to keep
>> > controls/statistics for any emulations that we add in the future, as opposed
>> > to littering them around in /proc or (worse) having a mixture of the two.
>> 
>> Yes, I understood that. I just had another idea: would it make sense to
>> use a tracepoint rather than a simple counter? That way you can actually
>> see who is using those instructions with ftrace.
>
> That would also be useful for perf, where the plain `emulation fault' event
> can be a little too broad.

I'll replace the counters with trace points.

There is still the pr_warn which informs the user about applications
using legacy instructions. Hopefully, this should encourage updating the
software.

>
>> You still wouldn't get the files in the same place as the enable switch
>> though. The easiest way to implement that switch btw would be a
>> module_param: It can be passed on the command line (using
>> swp_emulate.enable=0) or at runtime by writing to
>> /sys/module/swp_emulate/parameters/enable.
>> 
>> If we do both, there is no longer a need to have any debugfs file logic,
>> which is also a plus.
>
> Sounds good to me.

Just a note: instead of being 'swp_emulate.enable=0' this'll be
'v7_obsolete.swp_emulate=0' and correspondingly for the other features.

I'll include these changes in the next version.

>
> Will
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
