From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 9 Feb 2012 15:58:05 -0800
Subject: [PATCH v4 4/4] gpio: pl061: enable interrupts with DT style
 binding
In-Reply-To: <4F34429E.8070605@gmail.com>
References: <1328308512-22594-1-git-send-email-robherring2@gmail.com>
 <1328308512-22594-5-git-send-email-robherring2@gmail.com>
 <20120209200435.GB2493@r65073-Latitude-D630>
 <4F34429E.8070605@gmail.com>
Message-ID: <20120209235805.GB3135@r65073-Latitude-D630>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 09, 2012 at 04:03:10PM -0600, Rob Herring wrote:
> 
> On 02/09/2012 02:04 PM, Shawn Guo wrote:
> > On Fri, Feb 03, 2012 at 04:35:12PM -0600, Rob Herring wrote:
> > ...
> >> @@ -126,18 +127,16 @@ static void pl061_set_value(struct gpio_chip *gc, unsigned offset, int value)
> >>  static int pl061_to_irq(struct gpio_chip *gc, unsigned offset)
> >>  {
> >>  	struct pl061_gpio *chip = container_of(gc, struct pl061_gpio, gc);
> >> -
> >> -	if (chip->irq_base <= 0)
> >> -		return -EINVAL;
> >> -
> >> -	return chip->irq_base + offset;
> >> +	if (!chip->irq_gc)
> >> +		return -ENXIO;
> >> +	return irq_find_mapping(chip->irq_gc->domain, offset);
> > 
> > If I understand the driver correctly, it will add a linear domain for
> > dt case.  Do you have code somewhere creating the mapping before this
> > irq_find_mapping gets called here?  The reason I'm asking this is I
> > have to call irq_create_mapping rather than irq_find_mapping here to
> > get imx gpio driver working with linear domain, otherwise the
> > irq_find_mapping call will fail.
> > 
> 
> Right, the user has to call irq_of_parse_and_map (which calls
> irq_create_mapping ultimately). Interrupts are allocated on demand. The
> dts needs to declare the gpio controller as an interrupt-controller and
> the node using the gpio line needs to set its interrupt parent and
> interrupt connection
> 
Yes, that's how dt users use irq.  But since I'm trying to make the
imx gpio irq_domain as linear for both non-dt and dt users.  Calling
irq_create_mapping here may make sense for me, since it will not
require all these non-dt users change the way they use gpio irq.

Even for dt users, there may have some case that can not work in the
way we expect.

	soc {
		#address-cells = <1>;
		#size-cells = <1>;
		compatible = "simple-bus";
		interrupt-parent = <&tzic>;
		ranges;

		esdhc at 70008000 { /* ESDHC2 */
			compatible = "fsl,imx51-esdhc";
			reg = <0x70008000 0x4000>;
			interrupts = <2>;
			cd-gpios = <&gpio1 6 0>;
			wp-gpios = <&gpio1 5 0>;
		};
	};

In above SD example, irq_of_parse_and_map will just work out the SD
controller internal irq to tzic.  How can we work out the card-detection
irq to gpio controller in the same way?

-- 
Regards,
Shawn
