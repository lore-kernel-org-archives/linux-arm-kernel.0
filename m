From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 27 Jun 2013 11:31:06 +0200
Subject: [RFC PATCH v2 03/12] dmaengine: PL08x: Rework LLI handling to be
 less fragile
In-Reply-To: <2212577.G2ANCYONVo@flatron>
References: <1371933764-24875-1-git-send-email-tomasz.figa@gmail.com>
 <1371933764-24875-4-git-send-email-tomasz.figa@gmail.com>
 <CACRpkdYm7gFVLzRpQ2J97M+-zQAug_ftJhyi_kniTgCk=GT_bQ@mail.gmail.com>
 <2212577.G2ANCYONVo@flatron>
Message-ID: <CACRpkdYx_K9OkDDcXtHCwg4U3tB+1p3uj35-090sdoH6PU5OZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 27, 2013 at 12:04 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:

>> > +#define MAX_NUM_TSFR_LLIS      512
>>
>> And I like this nice side effect that we allocate a number of LLIs
>> rather than a fixed-size buffer.
>
> As we're at it, is there any reason to choose this particular number of
> LLis? I have calculated it from the buffer size defined originally, but I
> wonder if 512 LLIs for single transfer isn't too much?

Hm that would be some kind of rule-of-thumb thing.

It depends on the typical DMA request size divided by the max
bytes you can stash into an LLI in the smallest case.

For example when issueing things like this:

dd if=/dev/mmc0 of=/dev/null

you can get *really* large LLI lists, maybe if you want to make
a real engineering exercise you could instrument the code to
accumulate a few stats and run this stressful usecase on the
S3C and see where you end up?

Then calculate backwards for the smaller LLI chunks of the
unmodified PL08x and get a proper estimate.

One way forward would be not to hardcode this as a
#define but making it a field of the vendor data I guess.

Yours,
Linus Walleij
