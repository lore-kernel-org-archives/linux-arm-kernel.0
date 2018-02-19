From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 19 Feb 2018 09:53:34 +0100
Subject: [PATCH 1/2] ARM: shmobile: Factor out complex condition
In-Reply-To: <e22632bc-c612-de23-0ceb-4e317d41b04b@gmail.com>
References: <20180217020642.21375-1-marek.vasut+renesas@gmail.com>
 <20180217081857.xowqahwnzob6titp@katana>
 <e22632bc-c612-de23-0ceb-4e317d41b04b@gmail.com>
Message-ID: <CAMuHMdX3j-4=RCB0bNhLt2Gj_8dKdEXa1Gger=40KYJ3rwgJ9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Sat, Feb 17, 2018 at 12:46 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> On 02/17/2018 09:18 AM, Wolfram Sang wrote:
>>> -    if ((client->addr == 0x58 && !strcmp(client->name, "da9063")) ||
>>> -        (client->addr == 0x68 && !strcmp(client->name, "da9210")) ||
>>> -        (client->addr == 0x70 && !strcmp(client->name, "da9210"))) {
>>> +    if (regulator_quirk_check(client, 0, "da9063") ||
>>> +        regulator_quirk_check(client, 1, "da9210") ||
>>> +        regulator_quirk_check(client, 2, "da9210")) {
>>
>> I am afraid I don't think this makes the code better, just different.
>> The index is as magic as the client address IMO. I was not super happy
>> with the array size depending on the detected board from a previous
>> patch already. But given the next patch which modifies the msg array
>> depending on the board, I think we really need to switch to seperate
>> message arrays per board. Everything else is too error prone and
>> unnecessarily cumbersome to understand.
>>
>> Other opinions?
>
> The code is awful, yes.
>
> I wonder if we could rather find all DA0063 and DA9210 PMICs in the DT,
> check if their IRQ lines are tied together and then generate the table
> above dynamically for whatever PMICs are present in the system. Then all
> that special-casing would go away as we'd extract the information from DT.

Yes, like I suggested 4 days ago ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
