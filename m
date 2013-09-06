From: jean.pihet@linaro.org (Jean Pihet)
Date: Fri, 6 Sep 2013 16:10:41 +0200
Subject: [PATCH 3/3] perf: parse the .debug_frame section in case
 .eh_frame is not present
In-Reply-To: <20130906101720.GA1055@krava.brq.redhat.com>
References: <1378317854-25965-1-git-send-email-jean.pihet@linaro.org>
 <1378317854-25965-4-git-send-email-jean.pihet@linaro.org>
 <20130905163030.GF1100@krava.brq.redhat.com>
 <CAFrcx1=QA3EpPAxx7Jx=87WbupAEFQ8L+t9pTJ=+3ucVTE+xtg@mail.gmail.com>
 <20130906101720.GA1055@krava.brq.redhat.com>
Message-ID: <CAFrcx1nvuCyxcBNgYPs8a6kd2c8ad2r6ogmQUkXEiDGbZygHzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 September 2013 12:17, Jiri Olsa <jolsa@redhat.com> wrote:
> On Fri, Sep 06, 2013 at 11:31:17AM +0200, Jean Pihet wrote:
>> Hi Jiri,
>>
>> On 5 September 2013 18:30, Jiri Olsa <jolsa@redhat.com> wrote:
>> > On Wed, Sep 04, 2013 at 08:04:14PM +0200, Jean Pihet wrote:
>> >> On ARM the debug info is not present in the .eh_frame sections but
>> >> instead in .debug_frame.
>> >> Use libunwind to load and parse the debug info.
>> >
>> > hum, cannot make final link:
>> >
>> > $ make LIBUNWIND_DIR=/opt/libunwind/
>> >     CHK -fstack-protector-all
>> >     CHK -Wstack-protector
>> >     CHK -Wvolatile-register-var
>> >     CHK -D_FORTIFY_SOURCE=2
>> >     CHK bionic
>> >     CHK libelf
>> >     CHK libdw
>> >     CHK -DLIBELF_MMAP
>> >     CHK -DLIBELF_MMAP
>> >     CHK libunwind
>> >     CHK libaudit
>> >
>> > ...
>> >
>> > make[1]: `liblk.a' is up to date.
>> >     SUBDIR /home/jolsa/linux-perf/tools/lib/traceevent/
>> >     LINK perf
>> > libperf.a(unwind.o): In function `find_proc_info':
>> > /home/jolsa/linux-perf/tools/perf/util/unwind.c:339: undefined reference to `_Ux86_64_dwarf_find_debug_frame'
>> > collect2: ld returned 1 exit status
>> > make: *** [perf] Error 1
>> >
>> >
>> > I'm using the latest code from git://git.sv.gnu.org/libunwind.git
>> >
>> > Looks like dwarf_find_debug_frame is not exported, although
>> > it looks like it is based on what I see in libunwind sources ;-)
>> >
>> > What did I miss?
>> libunwind needs to be configured with --enable-debug-frame for the
>> debug_frame code to be included in the lib.
>> On ARM the flag is always set while it isn't on x86. Here is the
>> culprit below (lines from libunwind configure).
>
> yay, thats it!
>
>>
>> Should that be changed in configure along with the changes in tools/perf?
>
> I guess it's ok
I wonder how to express the dependency between the perf changes and
the libunwind version and configure flags. Is a note in the commit
descritpion enough?
I fear that the change can break many build systems...

>
> Other than that tabs misformating the 'perf tool' change looks ok.
Ok I will respin the code with the typo and formatting changes.

>
> I tested the '.eh_frame' code and it's still working. Once
> I figure out how to create a x86 binary with .debug_frame
> data I'll test the code itself ;-)
Great!

>
> If you could think of any automated testcase for this that could
> be added under 'tests' that'd be nice (not necessarily)
Ok will look at it. Linaro has automated tests that I need to write as
well so rather do it in perf/tests directly ;-p

>
> thanks,
> jirka

Thanks!
Jean
