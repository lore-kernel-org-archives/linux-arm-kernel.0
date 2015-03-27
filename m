From: panand@redhat.com (Pratyush Anand)
Date: Sat, 28 Mar 2015 02:41:53 +0530
Subject: arm64 kexec hang
In-Reply-To: <1427477015.27739.30.camel@infradead.org>
References: <1427477015.27739.30.camel@infradead.org>
Message-ID: <5515C799.8010600@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geoff,

On Friday 27 March 2015 10:53 PM, Geoff Levand wrote:
> Hi Pratyush,
>
> On Wed, 2015-03-25 at 15:55 +0530, Pratyush Anand wrote:
>> So with following changes kexec load seems to complete without any
>> error. However, kexec reboot does not work yet, Nothing after bye
>> message :( (1st kernel booted with maxcpus=1)
>
> 'Bye!' doesn't mean much, other than the first kernel has
> almost shutdown.  I recommend for debugging you either define
> ARM64_DEBUG_PORT for the kexec-tools build, or have a suitable
> earlyprintk= on the kernel command line.  See the read_sink()
> routine in kexec-arm64.c.
>

Well, I was already using earlycon and it did not print anything after 
*Bye*.

I got OCD-H and is able to track the flow atleast and to see when it dies.

So, it all goes like machine_kexec ->..... -> arm64_kexec_kimage_start 
-> purgatory_start -> purgatory -> printf ... -> putchar

Here it dies (goes to el2_sync_invalid) as arm64_sink does not seem to 
be correct. arm64_sink is (-1) 0xffffffffffffffff. I also tried by just 
returning from printf without doing anything, still it goes to 
el2_sync_invalid (may be from some other location).

I will try to see tomorrow why arm64_sink is wrong and why did not it 
work if printf was null.

just for info: is_hyp_mode_available is true in my case.

~Pratyush


> Either of these will output something like this from the
> purgatory code:
>
>    I'm in purgatory
>    purgatory: kernel_entry: 0000000080080000
>    purgatory: dtb:          0000000080760000
>
> Another option is to add my 'debugging: early putc' patch,
> build the kernel with ARM64_DEBUG_PORT defined for your
>   board.  This will output 'stext' when the second
> stage kernel is entered
>
> The kexec --lite option will bypass purgatory and should just
> show 'stext'.
>
> -Geoff
>
>
> _______________________________________________
> kexec mailing list
> kexec at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>
