From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 30 Aug 2017 07:31:41 -0500
Subject: linux-next regression caused by "gpiolib: request the gpio before
 querying its direction"
In-Reply-To: <20170830112424.7a3a7c36@windsurf.lan>
References: <20170830112424.7a3a7c36@windsurf.lan>
Message-ID: <3cce6903-d167-1bfc-38b4-1fdd7b3ff24b@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/30/17 4:24 AM, Thomas Petazzoni wrote:
> Therefore, with Timur's commit applied, when the system boots, we get
> serial output, up to the point where gpiochip_add_data() is called, and
> requests all GPIOs. Since our UART pins are not requested at the
> pinctrl level, the gpio_request succeeds and re-muxes those pins as
> GPIOs: we lose the UART.

This part I don't understand.  My patch just only impacts the code that 
queries the direction of the GPIO.  It does not set the direction.

When gpiochip_add_data() calls chip->request, what function is that calling?

The only thing I can think of is that the ->request function is not just 
returning status, but is also muxing the GPIO.  If so, then I think 
that's a bug.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
