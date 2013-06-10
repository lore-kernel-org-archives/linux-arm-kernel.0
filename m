From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 10 Jun 2013 20:34:44 +0200
Subject: [PATCH 2/3] ARM: dts: Add FIMD node to Origen4210 board
In-Reply-To: <51B55296.5030006@linaro.org>
References: <1370603235-11193-1-git-send-email-tushar.behera@linaro.org>
 <5527415.fcM1OgADxD@flatron> <51B55296.5030006@linaro.org>
Message-ID: <4092650.9kTauzjmyN@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 10 of June 2013 09:44:14 Tushar Behera wrote:
> On 06/08/2013 04:19 PM, Tomasz Figa wrote:
> > On Friday 07 of June 2013 16:37:14 Tushar Behera wrote:
> >> From: Sachin Kamat <sachin.kamat@linaro.org>
> >> 
> >> Added FIMD and display timing node to Origen4210 board.
> >> 
> >> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> >> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
> >> ---
> >> 
> >>  arch/arm/boot/dts/exynos4210-origen.dts |   21 +++++++++++++++++++++
> >>  1 file changed, 21 insertions(+)
> >> 
> >> diff --git a/arch/arm/boot/dts/exynos4210-origen.dts
> >> b/arch/arm/boot/dts/exynos4210-origen.dts index bcf8079..4c6c3cd
> >> 100644
> >> --- a/arch/arm/boot/dts/exynos4210-origen.dts
> >> +++ b/arch/arm/boot/dts/exynos4210-origen.dts
> >> @@ -290,4 +290,25 @@
> >> 
> >>  			clock-frequency = <24000000>;
> >>  		
> >>  		};
> >>  	
> >>  	};
> >> 
> >> +
> >> +	fimd at 11c00000 {
> >> +		pinctrl-0 = <&lcd_en &lcd_clk &lcd_data24 &pwm0_out>;
> > 
> > Ahh, this would explain the two pwm pin groups from previous patch.
> > 
> > This seems somehow incorrect, though. AFAIK PWM outputs are not
> > managed by FIMD in any way.
> 
> I couldn't find any better place to put the pwm0_out pin configurations.
> Without configuring pwm0_out pins, display doesn't come up on the LCD.
> Any suggestions?

Isn't there a PWM backlight driver? With my [PATCH 00/15] Final Samsung 
PWM support cleanup patches, a DT-compatible PWM driver is being added, so 
it should be possible to use it in your case.


> >> +		pinctrl-names = "default";
> >> +		status = "okay";
> >> +	};
> >> +
> >> +	display-timings {
> >> +		native-mode = <&timing0>;
> >> +		timing0: timing {
> >> +			clock-frequency = <50000>;
> > 
> > Hmm, 50 KHz for pixel clock? Isn't it a bit too low? Or am I missing
> > something?
> 
> Actually clock-frequency value is not used by DRM-FIMD, but instead
> required by the framework.
> 
> Still it would be better to provide the actual pixel clock value here.
> So I would update this with 40MHz which is actual pixel clock used on my
> board.

Yes, I think this is a much better idea.

Thanks,
Tomasz

> > Best regards,
> > Tomasz
> > 
> >> +			hactive = <1024>;
> >> +			vactive = <600>;
> >> +			hfront-porch = <64>;
> >> +			hback-porch = <16>;
> >> +			hsync-len = <48>;
> >> +			vback-porch = <64>;
> >> +			vfront-porch = <16>;
> >> +			vsync-len = <3>;
> >> +		};
> >> +	};
> >> 
> >>  };
> 
> Thanks for your review.
