From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 9 Sep 2015 10:39:46 +0200
Subject: [PATCH-v2 4/7] mmc: sdhci-pxav3: Add pinctl setting according to
 bus clock
In-Reply-To: <55EEF99F.1020904@linaro.org>
References: <1441624721-15612-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1441624721-15612-5-git-send-email-vaibhav.hiremath@linaro.org>
 <CACRpkdY59roEBgUd9TR39yNgfhw393+WmHQQAeLkOEZLChOcWQ@mail.gmail.com>
 <55EEF99F.1020904@linaro.org>
Message-ID: <CACRpkdaQc8bH923D1bvoj2+2Puq8sSaLLf5Y8cHKbAKziOwJMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 8, 2015 at 5:07 PM, Vaibhav Hiremath
<vaibhav.hiremath@linaro.org> wrote:

> But I still have one small doubt on expectation from
> devm_pinctrl_get() function.
>
> If pinctrl properties are not populated in Devicetree node,
> then, shouldn't devm_pinctrl_get() return error ?
> I followed the code flow, and it seems even if pinctrl properties are
> not populated in DT node, the devm_pinctrl_get() returns valid
> pointer to "struct pinctrl", isn't this against the expectation of the
> call?
>
>
> Code flow -
>
> devm_pinctrl_get()
> ...
> --> creat_pinctrl()

That is the spelling mistake Dennis Ritchie and Ken Thompson
wish they had avoided in the first syscall interface :D

> --> pinctrl_dt_to_map()
> ...
>
> pinctrl_dt_to_map() iterates for pinctrl-x (x = 0,1,...) and if it
> founds the entry then it parses the node. If it doesn't find any
> pinctrl property then also it returns 0. and subsequently rreturns
> handle to "struct pinctrl" for the device. Why is so?

So pinctrl_dt_to_map() returns 0 if there are no maps in the
device tree.

This is correct: there may be systems that have a mixture
of device tree and platform data, and in that case the code
needs to continue after calling pinctrl_dt_to_map() because
else it bails out before coming to the loop in
create_pinctrl() where we iterate over the static maps.

So after the loop in create_pinctrl() it should be possible
to return something like -ENOENT if we didn't find
anything. The device core pinctrl handling in
drivers/base/pinctrl.c seems to cope with it.

It's a semantic change so we would need to test to toss
it in and see what happens on some different systems
but in principe I think you're right. What we get if there is
no state is basically a dummy pinctrl that does nothing.

Do you wanna make a patch for this?

(Looping in Stephen Warren so he can tell if I miss something
obviously evident in the design that require stubs to
be present.)

Yours,
Linus Walleij
