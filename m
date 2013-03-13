From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 13 Mar 2013 15:09:33 +0800
Subject: [PATCH v2 05/14] ARM: integrator: use clocksource_of_init for
 sp804
In-Reply-To: <CACRpkdbCJd-ag1gLrJqJZ1D6+E5eX2tNuuNAtiKgtuBsxmrpmA@mail.gmail.com>
References: <1363108124-17484-1-git-send-email-haojian.zhuang@linaro.org>
 <1363108124-17484-6-git-send-email-haojian.zhuang@linaro.org>
 <513F7EBD.80207@gmail.com> <201303121933.47994.arnd@arndb.de>
 <513F9597.8050000@gmail.com>
 <CAD6h2NTNFZM4cgDmCJG+NrNbd27MdXGGsRCTpC1bJGeMAgcP-g@mail.gmail.com>
 <CACRpkdbCJd-ag1gLrJqJZ1D6+E5eX2tNuuNAtiKgtuBsxmrpmA@mail.gmail.com>
Message-ID: <CAD6h2NRDJuGTTZ1B0iy__2SYYw7R18NRqQcwjsSvMJ3gA4E_WQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 March 2013 14:41, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Mar 13, 2013 at 3:04 AM, Haojian Zhuang
> <haojian.zhuang@linaro.org> wrote:
>> On 13 March 2013 04:52, Rob Herring <robherring2@gmail.com> wrote:
>>> On 03/12/2013 02:33 PM, Arnd Bergmann wrote:
>>>> On Tuesday 12 March 2013, Rob Herring wrote:
>>>>> On 03/12/2013 12:08 PM, Haojian Zhuang wrote:
>>>
>>> Since the primecell ID registers are defined to be at 0xFF? offset, it
>>> is quite impossible for the integrator timers to have the ID registers
>>> within their 0x100 address space.
>>>
>> I'm sorry that I don't know this. I can add "arm,integrator-timer" into
>> compatible table of sp804 driver. I think that we could resolve this
>> issue. What's your opinion?
>
> As per the other discussion:
>
> The Integrator/AP has a timer which is different from the SP804.
>
> The Integrator/CP has an SP804.
>
> Please restrict the patch set to Integrator/CP.
>
> Yours,
> Linus Walleij

According to Rob's comment, I thought that only prime-cell ID registers
are not contained in integrator-timer controller.

Yes, I missed to include lookup to handle integrator-ap timer. I think that
we can use a string name that are binded to different compatible name.
Code is in below.

#define SP804_TIMER       0
#define INTEGRATOR_TIMER     1
#define ID_BUF_SIZE         16

match table:
{.compatible = "arm,sp804", .data = SP804_TIMER, },
{.compaitlbe = "arm,integrator-timer", .data = INTEGRATOR_TIMER, },

sp804_get_clock_rate():
    char dev_id_buf[ID_BUF_SIZE];
    if (match->data)
        snprintf(dev_id_buf, ID_BUF_SIZE, "ap_timer");
    else
        snprintf(dev_id_buf, ID_BUF_SIZE, "sp804");
    clk = clk_get_sys(dev_id_buf, name);

sp804_dt_init_clk():
    char dev_id_buf[ID_BUF_SIZE];
    if (match->data)
        snprintf(dev_id_buf, ID_BUF_SIZE, "ap_timer");
    else
        snprintf(dev_id_buf, ID_BUF_SIZE, "sp804");
    lookup = clkdev_alloc(clk, name, dev_id_buf);

I think it won't break out code any more. Since most code are same, we
could handle it in the same driver.

Regards
Haojian
