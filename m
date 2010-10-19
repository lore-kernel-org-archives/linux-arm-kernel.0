From: simon@sequanux.org (Simon Guinot)
Date: Tue, 19 Oct 2010 08:36:56 +0000
Subject: [PATCH 1/2] hwmon: add generic GPIO fan driver
In-Reply-To: <20101019065221.GA12406@ericsson.com>
References: <20101017154021.GB29120@kw.sim.vm.gnt>
	<1287330612-11256-1-git-send-email-simon@sequanux.org>
	<20101018160830.GB9033@ericsson.com>
	<20101018203610.GD29120@kw.sim.vm.gnt>
	<20101019065221.GA12406@ericsson.com>
Message-ID: <20101019083656.GE29120@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guenter,

On Mon, Oct 18, 2010 at 11:52:21PM -0700, Guenter Roeck wrote:
> On Mon, Oct 18, 2010 at 04:36:10PM -0400, Simon Guinot wrote:
> [ ... ]
> > > I don't really understand the value of supporting pwm attributes,
> > > since you have to convert those to rpm anyway. Why not just stick
> > > with fan1_input and fan1_target ? This would simplify the code a lot.
> > 
> > I don't know very well the hwmon API. I have simply been fooled by the
> > sysfs-interface document which claim that fan[1-*]_target only make
> > sense for a closed-loop fan. Moreover, I was expecting gpio-fan to be
> > compliant with the fancontrol shell script...
> > 
> > But anyway, you are right. I just don't want the pwm interface.
> > 
> Thinking more about this, another option might be to keep using
> the pwm interface (for fancontrol), but simplify your code.
> Your transitions are currently pwm -> rpm -> ctrl and vice versa.
> However, direct conversion pwm -> ctrl should also be possible
> and would be much simpler than the two-stage conversion.
> 
> To do that, you could map num_speed directly to the pwm range of (0..255).
> Something like
> 
> 	pwm = DIV_ROUND_CLOSEST(speed_index * 255, num_speed - 1);
> and
> 	speed_index = pwm * (num_speed - 1) / 255;
> 
> Then use speed_index to get control value and rpm from the speed table.
> 
> Would that make sense ? You could then also provide fan1_target
> for direct fan speed control.

Unfortunately, I believe this approximation is not possible. Take a look
at the Network Space Max fan speed array:

/* Designed for fan 40x40x16: ADDA AD0412LB-D50 6000rpm at 12v */
static struct gpio_fan_speed netspace_max_v2_fan_speed[] = {
        {    0,  0 },
        { 1500, 15 },
        { 1700, 14 },
        { 1800, 13 },
        { 2100, 12 },
        { 3100, 11 },
        { 3300, 10 },
        { 4300,  9 },
        { 5500,  8 },
};

The function rpm_speed(index) is really not linear. I am not sure about
the resulting behaviour when this will be used by a userland fan control
process...

If the pwm interface must be exported, I think we have to respect the
fan speed array. But as you said, maybe the work is rather on the
fancontrol script side.

As a first step, we could keep the heavy pwm interface. Once the
fancontrol script (or something else) will be able to handle the rpm
attributes, we will drop the pwm compatibility.
Simply remove the gpio-fan pwm interface seems a good option too...

Both make sense for me. Let me know your favourite way.

Thanks,

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101019/bb23fe5a/attachment-0001.sig>
