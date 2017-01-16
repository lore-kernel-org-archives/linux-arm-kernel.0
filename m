From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Mon, 16 Jan 2017 19:19:25 +0100
Subject: [PATCH 1/2] spi: pxa2xx: Prepare for edge-triggered interrupts
In-Reply-To: <CAHp75VfAiZZaU8VzUjwvaCMnAVapp46KoRz8yD8aG2BanBnRyA@mail.gmail.com>
References: <cover.1484557560.git.jan.kiszka@siemens.com>
 <6fe26505e67790b27eed28fd7451b51e70b7e8ba.1484557560.git.jan.kiszka@siemens.com>
 <1484558690.2133.132.camel@linux.intel.com>
 <7cb06bc7-bcb6-a212-8241-20ad4b2a4a90@siemens.com>
 <CAHp75VfAiZZaU8VzUjwvaCMnAVapp46KoRz8yD8aG2BanBnRyA@mail.gmail.com>
Message-ID: <3379e9ed-091b-1c0f-852a-aa32cb6abae1@siemens.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-01-16 18:53, Andy Shevchenko wrote:
> On Mon, Jan 16, 2017 at 1:18 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>> On 2017-01-16 10:24, Andy Shevchenko wrote:
>>> On Mon, 2017-01-16 at 10:05 +0100, Jan Kiszka wrote:
>>>> When using the a device with edge-triggered interrupts, such as MSIs,
>>>> the interrupt handler has to ensure that there is a point in time
>>>> during
>>>> its execution where all interrupts sources are silent so that a new
>>>> event can trigger a new interrupt again.
>>>>
>>>> This is achieved here by looping over SSSR evaluation. We need to take
>>>> into account that SSCR1 may be changed by the transfer handler, thus
>>>> we
>>>> need to redo the mask calculation, at least regarding the volatile
>>>> interrupt enable bit (TIE).
>>>
>>> Could you split this to two patches, one just move the code under
>>> question to a helper function (no functional change), the other does
>>> what you state in commit message here?
>>
>> IMHO, factoring out some helper called from the loop in ssp_int won't be
>> a natural split due to the large number of local variables being shared
>> here. But maybe I'm not seeing the design you have in mind, so please
>> propose a useful helper function signature.
> 
> At least everything starting from if (!...) {} can be a helper with
> only one parameter. Something like:
> 
> static int handle_bad_msg(struct driver_data *drv_data)
> {
>   if (...)
>     return 0;
> 
>   ...handle it...
>   return 1;
> }
> 
> Let's start from above.

OK, but I'll factor out only the handling block, ie. after the if.
That's more consistent.

> 
> P.S. Btw, you totally missed SPI list/maintainers. And you are using
> wrong Jarkko's address.

Data-mined this from the list, both typical target group as well as
Jarkko's address that he tends to use. Will adjust.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
