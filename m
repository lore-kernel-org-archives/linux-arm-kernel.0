From: prarit@redhat.com (Prarit Bhargava)
Date: Thu, 7 Dec 2017 14:03:20 -0500
Subject: [PATCH 2/2] acpi, x86: Use SPCR table for earlycon on x86
In-Reply-To: <CAOZdJXXdeY0+SRfSQC_X-L1UNemigO7DDgRk7jRdMKVe34NWvQ@mail.gmail.com>
References: <20171207172912.17868-1-prarit@redhat.com>
 <20171207172912.17868-3-prarit@redhat.com>
 <CAOZdJXXdeY0+SRfSQC_X-L1UNemigO7DDgRk7jRdMKVe34NWvQ@mail.gmail.com>
Message-ID: <c6ff196d-98e4-ab31-5d51-c342539afe96@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/07/2017 01:46 PM, Timur Tabi wrote:
> On Thu, Dec 7, 2017 at 11:29 AM, Prarit Bhargava <prarit@redhat.com> wrote:
>> -int __init acpi_parse_spcr(bool earlycon)
>> +int __init acpi_parse_spcr(bool earlycon, bool enable_console)
>>  {
>>         static char opts[ACPI_SPCR_OPTS_SIZE];
>>         static char uart[ACPI_SPCR_BUF_SIZE];
>> @@ -113,7 +113,8 @@ int __init acpi_parse_spcr(bool earlycon)
>>         if (earlycon)
>>                 setup_earlycon(opts);
>>
>> -       err = add_preferred_console(uart, 0, opts + strlen(uart) + 1);
>> +       if (enable_console)
>> +               err = add_preferred_console(uart, 0, opts + strlen(uart) + 1);
> 
> So if earlycon==true but enable_console==false, then you parse SPCR
> and use it for the early console, but not the primary console?  I'm
> not sure what that gives you.
> 

On arm64 the original SPCR code provides both early and primary consoles (as
you've pointed out).  IOW, if SPRC exists on arm64 a console will be
initialized.  That is still the case after my change.

The expected behaviour on x86 is that unless someone specifies 'earlycon' or
'console=' that no console should be initialized.  There are users (some IOT
boxes, etc.) that do NOT want a console.

The above code keeps the existing x86 behaviour.

P.
