From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Wed, 7 Nov 2012 10:50:48 +0530
Subject: [PATCH v2 5/6] ARM: davinci: remoteproc board support for
 OMAP-L138 DSP
In-Reply-To: <13514BD7FAEBA745BBD7D8A672905C14311F1E5E@DFLE08.ent.ti.com>
References: <1351197357-23528-1-git-send-email-rtivy@ti.com>
 <1351197357-23528-5-git-send-email-rtivy@ti.com>
 <CAPcSpEKDAEp5rS8RRpcyHN9WUUtJNppUuKvnZ6YX-tgertJBNQ@mail.gmail.com>
 <CA+V-a8uUHm5QEvzv4wxift2RTV5bLUVEJ8XBWyMZLSqNQssnhQ@mail.gmail.com>
 <13514BD7FAEBA745BBD7D8A672905C14311F1E5E@DFLE08.ent.ti.com>
Message-ID: <CA+V-a8v7611a00Z54H4Yd+FXFmpfg7jje3gdNCcbtS8axqGpOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,

On Wed, Nov 7, 2012 at 1:03 AM, Tivy, Robert <rtivy@ti.com> wrote:
> Hi Prabhakar,
>
> Thanks for your consideration, please see my response below...
>
>> -----Original Message-----
>> From: Prabhakar Lad [mailto:prabhakar.csengg at gmail.com]
>> Sent: Monday, November 05, 2012 9:02 PM
>> To: Tivy, Robert; Ben Gardiner
>> Cc: davinci-linux-open-source at linux.davincidsp.com; linux-arm-
>> kernel at lists.infradead.org; Marek Szyprowski
>> Subject: Re: [PATCH v2 5/6] ARM: davinci: remoteproc board support for
>> OMAP-L138 DSP
>>
>> Hi Robert,
>>
>> On Thu, Nov 1, 2012 at 7:22 PM, Ben Gardiner
>> <bengardiner@nanometrics.ca> wrote:
>> > Hi Rob,
>> >
>> > On Thu, Oct 25, 2012 at 4:35 PM, Robert Tivy <rtivy@ti.com> wrote:
>> >> [...]
>> >> @@ -660,6 +667,99 @@ int __init da850_register_mmcsd1(struct
>> davinci_mmc_config *config)
>> >>  }
>> >>  #endif
>> >>
>> >> +static struct platform_device *da8xx_dsp;
>> >> +
>> >> +#ifdef CONFIG_CMA
>> >> +
>> >> +/*
>> >> + * The following address range was chosen because the XDC Platform
>> for
>> >> + * OMAP-L138 DSP has this range as its default code/data placement.
>> >> + */
>> >> +#define DA8XX_RPROC_CMA_BASE  (0xc3000000)
>> >> [...]
>> >> +/*
>> >> + * The following address range was chosen because the XDC Platform
>> for
>> >> + * OMAP-L138 DSP has this range as its default code/data placement.
>> >> + *
>> >> + * System integrators must ensure that Linux does not own this
>> range.
>> >> + */
>> >> +#define DA_CONTIG_BASE (0xc3000000)
>> >> +#define DA_CONTIG_SIZE (0x02000000)
>> >
>> Is there a specific requirement for the dsp dev to have the buffers
>> from
>> this '0xc3000000' address range only ? If yes then
>> dma_declare_contiguous()
>> is must to ensure contiguous memory so the above macros cant be
>> avoided.
>> If there isn't a requirement of a specific region for dsp device you
>> can use a
>> global CMA instead, so as to ensure you have contiguous memory.
>
> The requirement is that the contiguous buffer matches the address range to which the DSP image was linked, including uninitialized sections that don't actually get loaded.
>
> I was thinking of making those #defines into Kconfig variables, so that kernel sources don't need to be touched by the end customer.  Another alternative is to make them be kernel command line variables, which would prevent the need to even rebuild the kernel.  What are your thoughts regarding those alternatives?

In either cases you still need a value which defaults, if the range was not
specified in command line or Kconfig value wasn?t set. In this case
you still need a macro with default value.

I would prefer passing the range as part of command line as it would
avoid rebuilding.

Regards,
--Prabhakar Lad

>
> The above address range was decided upon because it matches the RTSC platform's defined area for OMAP-L138 [1] (although, the customer can end up redefining that range).  One of the reasons that range was chosen for the RTSC platform is that it exists on boards with smaller DDR sizes.  In other words, for a board with 256MB of DDR, if a range at the top of the DDR address space was chosen then that DSP image wouldn't work with a board with only 128MB.
>
> Regards,
>
> - Rob
>
> [1] http://rtsc.eclipse.org/cdoc-tip/index.html#ti/platforms/evmOMAPL138/Platform.html#per-instance_config_parameters, however, we extended the range an additional 16MB beyond the RTSC platform's range.
>
>>
>> Regards,
>> --Prabhakar Lad
>>
>> > I am concerned with the rigidity of the memory hole as its definition
>> > is currently proposed.
>> >
>> > As you noted DA_CONTIG_BASE and DA_CONTIG_SIZE must describe a range
>> > that is not used by Linux. Ideally this hole would not be in the
>> > middle of the usuable memory but instead at the top. For L138 boards
>> > with larger DDR packages this would mean carrying a patch to this
>> > file.
>> >
>> > I think the same also applies to DA8XX_RPROC_CMA_BASE but I have no
>> > hands-on experience yet with CMA.
>> >
>> > Is there any other means by which the hole's location and size can be
>> > specified which does not require patching this file? I imagine
>> KConfig
>> > would work, but is this an acceptable use of KConfig?
>> >
>> > Best Regards,
>> > Ben Gardiner
>> >
>> > ---
>> > Nanometrics Inc.
>> > http://www.nanometrics.ca
>> > _______________________________________________
>> > Davinci-linux-open-source mailing list
>> > Davinci-linux-open-source at linux.davincidsp.com
>> > http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-
>> source
