From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 17 Mar 2015 21:35:56 +0100
Subject: [PATCH v2 3/8] ARM: add macro to perform far branches (b/bl)
In-Reply-To: <20150313164005.GU8656@n2100.arm.linux.org.uk>
References: <1426248452-4773-1-git-send-email-ard.biesheuvel@linaro.org>
 <1426248452-4773-4-git-send-email-ard.biesheuvel@linaro.org>
 <20150313164005.GU8656@n2100.arm.linux.org.uk>
Message-ID: <CAKv+Gu_DDEdJ6i-rL+h0RCpOB1oK5Qveu7PBfVBV=tGaoT=abw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 March 2015 at 17:40, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Mar 13, 2015 at 01:07:27PM +0100, Ard Biesheuvel wrote:
>> +     .macro  bl_abs, target, c=
>> +#if defined(CONFIG_CPU_32v7) || defined(CONFIG_CPU_32v7M)
>> +     movt\c  lr, #:upper16:\target
>> +     movw\c  lr, #:lower16:\target
>> +     blx\c   lr
>
> So I've looked this up, and it's valid, which is surprising because BLX
> itself writes to LR - the read from LR must happen before BLX itself
> writes to LR.  Thankfully, because of the pipelining, this is probably
> guaranteed.
>

I hadn't given it another thought, to be honest, as arithmetic
instructions can also use the same register as input and output.
But I suppose branch instructions don't go through all the ordinary
pipeline stages

> I wonder whether there will be any errata on this... maybe on non-ARM
> CPUs?  It'll be interesting to find out what happens once we merge
> this... :)
>
