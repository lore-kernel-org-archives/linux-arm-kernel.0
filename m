From: Claudiu.Beznea@microchip.com (Claudiu Beznea)
Date: Fri, 2 Mar 2018 11:28:09 +0200
Subject: [PATCH v3 05/10] pwm: add PWM mode to pwm_config()
In-Reply-To: <87r2p4hod7.fsf@intel.com>
References: <1519300881-8136-1-git-send-email-claudiu.beznea@microchip.com>
 <1519300881-8136-6-git-send-email-claudiu.beznea@microchip.com>
 <20180228194429.GD22932@mithrandir> <87r2p4hod7.fsf@intel.com>
Message-ID: <585cc4ae-3674-c119-295b-e59f4242e619@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 28.02.2018 22:04, Jani Nikula wrote:
> On Wed, 28 Feb 2018, Thierry Reding <thierry.reding@gmail.com> wrote:
>> Anyone that needs something other than normal mode should use the new
>> atomic PWM API.
> 
> At the risk of revealing my true ignorance, what is the new atomic PWM
> API? Where? Examples of how one would convert old code over to the new
> API?
As far as I know, the old PWM core code uses config(), set_polarity(),
enable(), disable() methods of driver, registered as pwm_ops:
struct pwm_ops {

        int (*request)(struct pwm_chip *chip, struct pwm_device *pwm);

        void (*free)(struct pwm_chip *chip, struct pwm_device *pwm);

        int (*config)(struct pwm_chip *chip, struct pwm_device *pwm,

                      int duty_ns, int period_ns);

        int (*set_polarity)(struct pwm_chip *chip, struct pwm_device *pwm,

                            enum pwm_polarity polarity);

        int (*capture)(struct pwm_chip *chip, struct pwm_device *pwm,

                       struct pwm_capture *result, unsigned long timeout);

        int (*enable)(struct pwm_chip *chip, struct pwm_device *pwm);

        void (*disable)(struct pwm_chip *chip, struct pwm_device *pwm);

        int (*apply)(struct pwm_chip *chip, struct pwm_device *pwm,

                     struct pwm_state *state);

        void (*get_state)(struct pwm_chip *chip, struct pwm_device *pwm,

                          struct pwm_state *state);

#ifdef CONFIG_DEBUG_FS

        void (*dbg_show)(struct pwm_chip *chip, struct seq_file *s);

#endif

        struct module *owner;

};


to do settings on hardware. In order to so settings on a PWM the users
should have been follow the below steps:
->config()
->set_polarity()
->enable()
Moreover, if the PWM was previously enabled it should have been first
disable and then to follow the above steps in order to apply a new settings
on hardware.
The driver should have been provide, at probe, all the above function:
->config(), ->set_polarity(), ->disable(), ->enable(), function that were
used by PWM core.

Now, having atomic PWM, the driver should provide one function to PWM core,
which is ->apply() function. Every PWM has a state associated, which keeps
the period, duty cycle, polarity and enable/disable status. The driver's
->apply() function takes as argument the state that should be applied and
it takes care of applying this new state directly without asking user to
call ->disable(), then ->config()/->set_polarity(), then ->enable() to
apply new hardware settings.

The PWM consumer could set a new state for PWM it uses, using
pwm_apply_state(pwm, new_state);

Regarding the models to switch on atomic PWM, on the controller side you
can check for drivers that registers apply function at probe time.
Regarding the PWM users, you can look for pwm_apply_state()
(drivers/hwmon/pwm-fan.c or drivers/input/misc/pwm-beeper.c are some examples).

Thierry, please correct me if I'm wrong.

Thank you,
Claudiu Beznea

> 
> BR,
> Jani.
> 
