From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Jun 2011 11:19:14 +0200
Subject: [PATCH 1/2] drivers: create a pinmux subsystem v3
In-Reply-To: <1307988690.26699.9.camel@Joe-Laptop>
References: <1307984291-9774-1-git-send-email-linus.walleij@stericsson.com>
	<1307988690.26699.9.camel@Joe-Laptop>
Message-ID: <BANLkTi=YQcQ2C=RhMrB_CpWXN7ba9SxfEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joe,

thanks for the review, excellent as always.

I fixed all except the below pattern, also searched the source to make sure
there were no other cases of the same errors.

On Mon, Jun 13, 2011 at 8:11 PM, Joe Perches <joe@perches.com> wrote:

>> +int pinctrl_register_pins_dense(struct pinctrl_pin_desc const *pins,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?unsigned num_descs, unsigned num_pins)
>> +{
>> + ? ? int ret;
>> + ? ? unsigned i;
>> +
>> + ? ? ret = pinctrl_register_pins(pins, num_descs, num_pins);
>> + ? ? if (ret) {
>> + ? ? ? ? ? ? for (i = 0; i < num_pins; i++) {
>> + ? ? ? ? ? ? ? ? ? ? struct pin_desc *pindesc;
>> +
>> + ? ? ? ? ? ? ? ? ? ? spin_lock(&pin_desc_tree_lock);
>> + ? ? ? ? ? ? ? ? ? ? pindesc = radix_tree_lookup(&pin_desc_tree, i);
>> + ? ? ? ? ? ? ? ? ? ? if (pindesc != NULL) {
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? radix_tree_delete(&pin_desc_tree, i);
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? num_pins --;
>> + ? ? ? ? ? ? ? ? ? ? }
>> + ? ? ? ? ? ? ? ? ? ? spin_unlock(&pin_desc_tree_lock);
>> + ? ? ? ? ? ? ? ? ? ? kfree(pindesc);
>> + ? ? ? ? ? ? }
>
> Second use of this pattern. ?Maybe use pinctrl_free_pindescs?

It is quite different actually - in the second case here. we loop over a list
with holes, and we pick each one pin. We cannot loop over the entire
pin range because in this case we don't know the size of the range.

Thanks,
Linus Walleij
