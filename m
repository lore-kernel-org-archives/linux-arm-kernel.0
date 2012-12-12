From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Wed, 12 Dec 2012 16:31:11 +0530
Subject: [PATCH v3 5/6] ARM: davinci: remoteproc board support for
 OMAP-L138 DSP
In-Reply-To: <50C85D9F.6050306@ti.com>
References: <1352853207-20602-1-git-send-email-rtivy@ti.com>
 <1352853207-20602-5-git-send-email-rtivy@ti.com> <50AB76FA.1050505@ti.com>
 <13514BD7FAEBA745BBD7D8A672905C14311F952B@DFLE08.ent.ti.com>
 <50B88F7C.5000705@ti.com>
 <13514BD7FAEBA745BBD7D8A672905C14311FBDA3@DFLE08.ent.ti.com>
 <50C85D9F.6050306@ti.com>
Message-ID: <CA+V-a8sTBXMCXoTAjbuT9HUJkw_Na5SRUz2qAwvrebQXPWg6Rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sekhar,

On Wed, Dec 12, 2012 at 4:04 PM, Sekhar Nori <nsekhar@ti.com> wrote:
> On 12/12/2012 7:06 AM, Tivy, Robert wrote:
>>> -----Original Message-----
>>> From: Nori, Sekhar
>>> Sent: Friday, November 30, 2012 2:51 AM
>>>
>>> Hi Rob,
>>>
>>> On 11/29/2012 7:08 AM, Tivy, Robert wrote:
>>>> Hi Sekhar,
>>>>
>>>> Please see comments and noob questions below...
>>>>
>>>> They can run a single image if the image supports overriding the
>>> Kconfig settings with kernel command-line arguments.
>>>>
>>>> The most basic solution is constants in the .c file itself.  A better
>>> solution is Kconfig settings used by the .c file.  An even better
>>> solution is Kconfig settings with kernel command-line overrides.
>>>
>>> If you have kernel command line, you could default to some values which
>>> are sane in most cases if they are not provided. No, need to have a
>>> Kconfig as well. That will be too many hooks to control the same things
>>> and probably not necessary.
>>>
>>>>
>>>>> If you want the remoteproc driver to allocate a certain area of
>>> memory
>>>>> to the dsp, why don't you take that value as a module parameter so
>>>>> people who need different values can pass them differently? It is
>>> not
>>>>> clear to me why this memory management needs to be dealt with in
>>>>> platform code.
>>>>
>>>> Unfortunetly we need to reserve this dsp memory during early boot,
>>> using CMA.  Runtime module insertion is too late.
>>>
>>> Then I guess most of the time the module would be built into the kernel
>>> and will be initialized using an early enough initcall.
>>
>> That's right, a .reserve function is assigned to the MACHINE_START structure, and this function calls dma_declare_contiguous().
>
> I meant use an early initcall in the driver.
>
>>
>>>>>> +
>>>>>> +static int __init early_rproc_mem(char *p) {
>>>>>> + char *endp;
>>>>>> +
>>>>>> + rproc_size = memparse(p, &endp);
>>>>>> + if (*endp == '@')
>>>>>> +         rproc_base = memparse(endp + 1, NULL);
>>>>>> +
>>>>>> + return 0;
>>>>>> +}
>>>>>> +early_param("rproc_mem", early_rproc_mem);
>>>>>
>>>>> Use of non-standard kernel parameters is discouraged. All kernel
>>>>> parameters should be documented in Documentation/kernel-
>>> parameters.txt
>>>>> (this means each and every kernel parameter needs to be justified
>>>>> well).
>>>>
>>>> Can I use the kernel command-line (i.e., u-boot bootargs variable) to
>>> specify non-kernel parameters?  I guess my question is more one about
>>> the terminology "kernel parameter" - is there a way to specify a module
>>> parameter on the kernel command line (like, perhaps, rproc.membase and
>>> rproc.memsize)?
>>>
>>> Right. Module parameters are passed from kernel command line when the
>>> module is built into the kernel.
>>
>> Unfortunately, it seems that module parameters, when stated on the kernel command line with module-name.var-name syntax, are not yet assigned when the kernel calls the early init .reserve functions.  For the "char *" I'm using, I observed a NULL value during the early init call and the proper assigned value during a later normal __init function.
>
> By "later normal __init" you mean module_init()? And you see
> dma_declare_contiguous() returning error by this time?
>
>>
>> Is there any other method that allows specifying a parameter for an early CMA reservation without having to rebuild the kernel?
>
> Nothing else comes to mind. Can you share your code in some public repo?
> It will allow me to try if something comes to mind.
>
>>
>> If not, is this a strong enough use case to justify a new kernel parameter?
>
> May be it it is. You could try adding it. Just update the documentation
> too. And add the documentation maintainers when you respin the patch.
>
I tried finding some alternatives apart from early_param, but there aren?t any.
The only thought I got from Marek is to have device tree support. How about
that as an option ?

Regards,
--Prabhakar Lad

>>
>> I guess I don't understand why non-standard kernel parameters are discouraged.  I can adorn the name with enough module-specific naming to reduce the chances of any namespace collisions to a minimum.
>
> I guess it is to make sure generic solutions are followed and every
> problem is not seen as unique.
>
> Thanks,
> Sekhar
> _______________________________________________
> Davinci-linux-open-source mailing list
> Davinci-linux-open-source at linux.davincidsp.com
> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
