From: guenter.roeck@ericsson.com (Guenter Roeck)
Date: Mon, 18 Oct 2010 23:52:21 -0700
Subject: [PATCH 1/2] hwmon: add generic GPIO fan driver
In-Reply-To: <20101018203610.GD29120@kw.sim.vm.gnt>
References: <20101017154021.GB29120@kw.sim.vm.gnt>
	<1287330612-11256-1-git-send-email-simon@sequanux.org>
	<20101018160830.GB9033@ericsson.com>
	<20101018203610.GD29120@kw.sim.vm.gnt>
Message-ID: <20101019065221.GA12406@ericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 18, 2010 at 04:36:10PM -0400, Simon Guinot wrote:
[ ... ]
> > I don't really understand the value of supporting pwm attributes,
> > since you have to convert those to rpm anyway. Why not just stick
> > with fan1_input and fan1_target ? This would simplify the code a lot.
> 
> I don't know very well the hwmon API. I have simply been fooled by the
> sysfs-interface document which claim that fan[1-*]_target only make
> sense for a closed-loop fan. Moreover, I was expecting gpio-fan to be
> compliant with the fancontrol shell script...
> 
> But anyway, you are right. I just don't want the pwm interface.
> 
Thinking more about this, another option might be to keep using
the pwm interface (for fancontrol), but simplify your code.
Your transitions are currently pwm -> rpm -> ctrl and vice versa.
However, direct conversion pwm -> ctrl should also be possible
and would be much simpler than the two-stage conversion.

To do that, you could map num_speed directly to the pwm range of (0..255).
Something like

	pwm = DIV_ROUND_CLOSEST(speed_index * 255, num_speed - 1);
and
	speed_index = pwm * (num_speed - 1) / 255;

Then use speed_index to get control value and rpm from the speed table.

Would that make sense ? You could then also provide fan1_target
for direct fan speed control.

Thanks,
Guenter
