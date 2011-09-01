From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 1 Sep 2011 13:12:07 +0200
Subject: [PATCH v2] pinmux: add a driver for the CSR SiRFprimaII pinmux
In-Reply-To: <1314843744-2910-1-git-send-email-Baohua.Song@csr.com>
References: <1314843744-2910-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <CACRpkdbb_5EZHT3=SNePbW-=NYjLSLzJgjEdEaBV7X=s6gxydw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 1, 2011 at 4:22 AM, Barry Song <Baohua.Song@csr.com> wrote:

> ?-v2:
> ?rebase to Linus W's v5 patch(v5 is still in discussion);
> ?add complete pinmux list table;
> ?add gpio ranges;
> ?replace mask magic number by bitops;
> ?rename upmx to spmx

No further comments on this, but now I went in and rewrote
pinmuxing a bit so that pin groups are a separate concept from
pinmux (which just refers to a group). Please have a look at
the U300 driver and see if you can accomodate the changes.

Sorry for the flow of respins but I'm really liking the stuff that
has come out as a result of Stephen's feedback. Having
separate groups and functions may look a bit crufty on
simple pinmuxes but I'm pretty convinced it'll be a win
for the subsystem when moving to more complex drivers.

> +static const struct sirfsoc_pinmux_func sirfsoc_pinmux_funcs[] = {
> + ? ? ? {
> + ? ? ? ? ? ? ? .name = "lcd_16bits",
> + ? ? ? ? ? ? ? .pins = lcd_16bits_pins,
> + ? ? ? ? ? ? ? .num_pins = ARRAY_SIZE(lcd_16bits_pins),
> + ? ? ? ? ? ? ? .padmux = &lcd_16bits_padmux,
> + ? ? ? }, {
> + ? ? ? ? ? ? ? .name = "lcd_18bits",
> + ? ? ? ? ? ? ? .pins = lcd_18bits_pins,
> + ? ? ? ? ? ? ? .num_pins = ARRAY_SIZE(lcd_18bits_pins),
> + ? ? ? ? ? ? ? .padmux = &lcd_18bits_padmux,
> + ? ? ? }, {

You can probably simplify this and other things with
preprocessor macros if you want to, like:

#define SIRF_FUNC_ENTRY(a) \
{ .name = "##a##", .pins = ##a##_pins, .num_pins =
ARRAY_SIZE(##a##_pins), .padmux = &##a##_padmux }

Then just:

static const struct sirfsoc_pinmux_func sirfsoc_pinmux_funcs[] = {
    SIRF_FUNC_ENTRY(lcd_16bits),


The macro syntax is probably wrong, the preprocessor always
craze me out, but you get the idea.

Thanks,
Linus Walleij
