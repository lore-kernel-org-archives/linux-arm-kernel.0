From: jonathan@jonmasters.org (Jon Masters)
Date: Sun, 25 Mar 2012 19:59:44 -0400
Subject: Inconsistent kallsyms data on ARM.
In-Reply-To: <20120325112035.GE5611@n2100.arm.linux.org.uk>
References: <CAP=VYLoStscdVJretZ-Rkbp7V3Vsm8N0oWcjih7ruHFiDN7CiA@mail.gmail.com>
 <201203141321.47010.arnd@arndb.de>
 <20120325112035.GE5611@n2100.arm.linux.org.uk>
Message-ID: <4F6FB170.1040109@jonmasters.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/25/2012 07:20 AM, Russell King - ARM Linux wrote:
> On Wed, Mar 14, 2012 at 01:21:46PM +0000, Arnd Bergmann wrote:
>> On Tuesday 13 March 2012, Paul Gortmaker wrote:
>>> This bug(?)  has been seen to float from one ARM build to another since
>>> I started tracking the day-to-day changes in Stephen's linux-next builds.
>>>
>>> I see it was discussed earlier:
>>>
>>>    https://lkml.org/lkml/2011/8/2/233
>>>    https://lkml.org/lkml/2011/10/8/70
>>>
>>> but no concrete cause was nailed down.  Can the linux-next build results
>>> help shed some light on this in any way?  Since it seems sporadic, is
>>> there value in embedding a diagnostic of some sort in the infrastructure
>>> so that when the error is detected, that it prints out more detailed info?
>>>
>>> I can provide links to failed linux-next builds, but at the moment, all they
>>> really seem to have is the same repeated error message, like this one:
>>>
>>>    http://kisskb.ellerman.id.au/kisskb/buildresult/5869367/
>>>
>>> and I don't see that helping folks all that much....
>>>
>>
>> I'm sure I can reproduce it if necessary, but I need to know what to
>> look for to find out what the problem is.
> 
> Right, last night's omap3430ldp build failed because of this, so I've
> re-run the build and taken a look at what's happened:
> 
> $ arm-linux-nm -n .tmp_vmlinux1 > vm1.syms
> $ arm-linux-nm -n .tmp_vmlinux2 > vm2.syms
> $ arm-linux-nm -n vmlinux > vm3.syms
> $ diff -u <(sed s,^...........,, vm2.syms) <(sed s,^...........,, vm3.syms) 
> $
> 
> .tmp_vmlinux1 is the vmlinux file with no kallsyms data.  .tmp_vmlinux2 is
> the vmlinux file with kallsyms data generated from the first image.
> vmlinux is the vmlinux file with kallsyms data generated from the second
> image.
> 
> What the above shows is that we have the same symbols in the same order
> in the second and third stage.  However:
> 
> $ diff -u vm2.syms vm3.syms
> ...
>  c0352900 R kallsyms_names
> -c03acd00 R kallsyms_markers
> -c03acf10 R kallsyms_token_table
> -c03ad290 R kallsyms_token_index
> ...
> +c03accf0 R kallsyms_markers
> +c03acf00 R kallsyms_token_table
> +c03ad280 R kallsyms_token_index
> 
> So, the size of the kallsyms names has changed.
> 
> Now, looking at the differences between stage 1 and stage 2:
> 
> @@ -1,9 +1,3 @@
> -kallsyms_addresses
> -kallsyms_markers
> -kallsyms_names
> -kallsyms_num_syms
> -kallsyms_token_index
> -kallsyms_token_table
>  syscalls_padding
>  cpu_v7_suspend_size
>  NR_syscalls
> @@ -17151,6 +17145,12 @@
>  rpc_info_operations
>  svc_pool_stats_seq_ops
>  rpc_proc_fops
> +kallsyms_addresses
> +kallsyms_num_syms
> +kallsyms_names
> +kallsyms_markers
> +kallsyms_token_table
> +kallsyms_token_index
>  __end_builtin_fw
>  __end_pci_fixups_early
>  __end_pci_fixups_enable
> @@ -28372,11 +28372,11 @@
>  __security_initcall_start
>  __initramfs_size
>  __irf_end
> -__data_loc
>  __init_end
>  __per_cpu_end
>  __per_cpu_load
>  __per_cpu_start
> +__data_loc
>  _data
>  _sdata
>  init_thread_union
> 
> 
> The difference in placement for the kallsyms symbols is more or less
> expected, because these appear as weak symbols in stage 1.  However,
> notice that __data_loc has moved in relative position.
> 
> As the names are compressed, this causes the size of the kallsyms name
> data to change size (because we end up with a different compression)
> which then causes the subsequent kallsyms data and other read-only data
> to move.  This then causes 'inconsistent kallsyms data' error.
> 
> Now, looking at the __data_loc values in these files:
> 
> vm1.syms-c03bd408 t __irf_start
> vm1.syms-c03bd408 T __security_initcall_end
> vm1.syms-c03bd408 T __security_initcall_start
> vm1.syms-c03bd608 T __initramfs_size
> vm1.syms-c03bd608 t __irf_end
> vm1.syms:c03be000 A __data_loc
> vm1.syms-c03be000 A __init_end
> vm1.syms-c03be000 D __per_cpu_end
> vm1.syms-c03be000 D __per_cpu_load
> vm1.syms-c03be000 D __per_cpu_start
> vm1.syms-c03be000 D _data
> --
> vm2.syms-c0438608 t __irf_end
> vm2.syms-c0439000 A __init_end
> vm2.syms-c0439000 T __per_cpu_end
> vm2.syms-c0439000 T __per_cpu_load
> vm2.syms-c0439000 T __per_cpu_start
> vm2.syms:c043a000 A __data_loc
> vm2.syms-c043a000 D _data
> vm2.syms-c043a000 D _sdata
> vm2.syms-c043a000 D init_thread_union
> vm2.syms-c043c000 D __nosave_begin
> vm2.syms-c043c000 D __nosave_end
> 
> What we see here is the start of the data section aligned to 8K as
> required for the init task data.  The per-cpu data is aligned to a 4K
> boundary immediately before it.  However, as it is an empty section,
> it can be aligned to the same 8K boundary as the data section depending
> on the size and placement of the previous sections which include the
> kallsyms data.
> 
> The solution?  We could artificially increase the alignment of the
> per-cpu data, or waste a byte after the per-cpu data to ensure that we
> don't align both together.  That could mean wasting up to 12K of space
> for no reason other than to avoid this error which is exceedingly silly.
> 
> I'm not sure whether the kallsyms name data generation could be
> changed so that this kind of thing doesn't matter but I suspect
> that's an exceedingly difficult problem to crack.
> 
> In the mean time, I'd suggest building with the additional kallsyms pass
> when it's required.

We've been hitting this in Fedora on particularly UP kernel builds. I
also came to the same conclusions that you did (see Google+) and had a
chat with Arnd about it. A test build with the __per_cpu_* data removed
from the linker vmlinux.lds succeeds in building for the reasons cited.
That's not to say that was the intended fix, just an experiment to
confirm that this is the problem we've been hitting on some builds.

The "problem" is that kallsyms uses a "compression" algorithm that
derives the name compressed from the type+symbol_name so
"T__per_cpu_start" becomes "D__per_cpu_start". The compression is very
trivial in that unused characters in the set of input symbols are used
to represent popular character pairs, etc. So when the symbol changes
type according to nm output (as you explain), the size of kallsyms_names
will likely change, changing all the offsets. I was going to report this
either this evening or in the morning, but I have been waiting for some
tests to complete. Glad you found it.

As to longer term, I am happy to work up something that will spot this
particular kind of failure (symbol changes type) and output something
more useful during the kallsyms generation if you would like.

Are you planning to pull in either of the fixes you mention?

Jon.
