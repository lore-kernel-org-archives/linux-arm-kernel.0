From: dianders@chromium.org (Doug Anderson)
Date: Mon, 20 Oct 2014 08:51:59 -0700
Subject: [PATCHv2 2/2] ARM: dts: socfpga: Add a 3.3V fixed regulator node
In-Reply-To: <1413819079-17120-3-git-send-email-dinguyen@opensource.altera.com>
References: <1413819079-17120-1-git-send-email-dinguyen@opensource.altera.com>
 <1413819079-17120-3-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <CAD=FV=XzQ0JHpNsu+fyuRGi6NHeVxwNdxuGTPny3+dbTDYCo5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dinh,

On Mon, Oct 20, 2014 at 8:31 AM,  <dinguyen@opensource.altera.com> wrote:
> +++ b/arch/arm/boot/dts/socfpga_arria5_socdk.dts
> @@ -37,6 +37,15 @@
>                 */
>                 ethernet0 = &gmac1;
>         };
> +
> +       regulator_3_3v: regulator {

I think it's better to give this a real node name.  The
"regulator_3_3v" will get dropped when you compile this into a binary
format (for shipping), so you're creating a node that's just called
"regulator".  If you had more than one fixed regulator like this it
just won't work.

I haven't seen any official guidelines, but I tend to use "regulator"
as a suffix and then put the schematic name.  Like:

  3_3v_regulator: 3-3-v-regulator


> +               compatible = "regulator-fixed";
> +               regulator-name = "3.3V";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +               regulator-boot-on;
> +               regulator-always-on;

It's probably not necessary to specify "boot-on" and "always-on" since
there's no GPIO backing this (in other words, those properties are
implied since there's no way to turn this regulator off).


I haven't gone back and checked this against your schematics, but they
look good to me.  Once you've fixed above you are free to add my
Reviewed-by if you wish.

-Doug
