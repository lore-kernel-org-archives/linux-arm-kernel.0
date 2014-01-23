From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Thu, 23 Jan 2014 11:56:32 +0100
Subject: [PATCH 1/2] PWM: let of_xlate handlers check args count
In-Reply-To: <1390467898-9216-2-git-send-email-s.hauer@pengutronix.de>
References: <20140123083714.3c6e86ae@ipc1.ka-ro>
 <1390467898-9216-1-git-send-email-s.hauer@pengutronix.de>
 <1390467898-9216-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20140123115632.6d3f1a58@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Sascha Hauer wrote:
> of_pwm_n_cells for the of_xlate handler is stored in struct pwm_chip,
> but it is only ever used by the of_xlate handler itsel. Remove
> of_pwm_n_cells from struct pwm_chip and let the handler do the argument
> count checking to simplify the code.
> 
This still does not make the PWM_POLARITY flag in the pwms node
optional as was the goal because of_parse_phandle_with_args() requires
at least #pwm-cells arguments in the node.

So, with a DT configuration like:
pwm0: pwm at 0 {
	#pwm-cells = <3>;
};
backlight {
	pwms = <&pwm0 0 100000>;
};
the driver will bail out at of_parse_phandle_with_args() in
of_pwm_get() with the error message:
"/backlight: arguments longer than property" and never reach your
clever xlate function.

Thus you will still need to replace of_parse_phandle_with_args()
with different code that copies most but not all of the functionality.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
