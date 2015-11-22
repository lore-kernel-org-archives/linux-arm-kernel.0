From: robh@kernel.org (Rob Herring)
Date: Sun, 22 Nov 2015 15:09:22 -0600
Subject: [PATCH 1/4] dt-bindings: gpio: update desription of LPC32xx GPIO
 controller
In-Reply-To: <564F6617.6090104@mleia.com>
References: <1447982995-30231-1-git-send-email-vz@mleia.com>
 <1447982995-30231-2-git-send-email-vz@mleia.com>
 <20151120141354.GA25446@rob-hp-laptop> <564F6617.6090104@mleia.com>
Message-ID: <20151122210922.GA6853@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2015 at 08:27:35PM +0200, Vladimir Zapolskiy wrote:
> On 20.11.2015 16:13, Rob Herring wrote:
> > On Fri, Nov 20, 2015 at 03:29:52AM +0200, Vladimir Zapolskiy wrote:
> >> For the purpose of better description of NXP LPC32xx GPIO controller
> >> hardware in device tree format, extend the existing description with
> >> device tree subnodes, which represent 6 GPIO banks within the
> >> controller.
> >>
> >> Note, client interface to the GPIO controller is untouched.
> >>
> >> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> >> ---
> >>  .../devicetree/bindings/gpio/gpio_lpc32xx.txt      | 121 ++++++++++++++++++++-
> >>  1 file changed, 120 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/gpio/gpio_lpc32xx.txt b/Documentation/devicetree/bindings/gpio/gpio_lpc32xx.txt
> >> index 4981936..d2da63c 100644
> >> --- a/Documentation/devicetree/bindings/gpio/gpio_lpc32xx.txt
> >> +++ b/Documentation/devicetree/bindings/gpio/gpio_lpc32xx.txt
> >> @@ -15,7 +15,43 @@ Required properties:
> >>     2) pin number
> >>     3) optional parameters:
> >>        - bit 0 specifies polarity (0 for normal, 1 for inverted)
> >> -- reg: Index of the GPIO group
> >> +- #address-cells: should be 2, which stands for GPIO bank id and
> >> +  physical base address of this GPIO bank.
> > 
> > Now you need special code to do address translation. I'd really think 
> > twice about doing this.
> 
> Correct, address translation code is needed here...
> 
> > Why do you need the bank number?
> 
> Only one reason -- backward compatibility in sense of referencing a GPIO
> line on client's side. This API design is broken, I agree.

What client exactly? Between the dtb and kernel or kernel and userspace 
or ...?

> Honestly I would prefer to get rid of this "feature", new code allows to
> reference on client's side either a parent GPIO controller device node,
> or bank nodes, probably the improvement can be done in a few steps?
> 
>   - this change,
>   - convert clients to reference a GPIO bank directly,
>   - remove root GPIO controller (e.g. make it "simple-bus") and convert
> GPIO banks to "gpio-controller"s.
> 
> Can an evolution like this happen?

You generally don't want bindings to evolve.


> >> +		gpio_p2: gpio-controller at 2 {
> >> +			reg = <2 0x10 0x18>;
> >> +			gpio-bank-name = "p2";
> >> +			gpios = <13>;
> >> +			gpio-no-output-state;
> >> +		};
> >> +
> >> +		gpio_gpio: gpio-controller at 3 {
> >> +			reg = <3 0x00 0x1C>;
> > 
> > This overlaps with bank 2.
> 
> Yes, it is. Thousand thanks to hardware designers.

Then you might want to split these into 2 regions. The problem is 
request_resource does not work with overlapping resources. Or just don't 
do subnodes. If there is not a lot of variations in the subnode data, 
then just leave that information in the kernel.

Rob
