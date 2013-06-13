From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 13 Jun 2013 13:38:14 -0600
Subject: [PATCH] drivers: pinctrl: add active state to core
In-Reply-To: <CACRpkdYQSO0+9tQkS=df-kpL=XL+DpnY1ijp6_Zeg0MvmFujyw@mail.gmail.com>
References: <1370938616-5952-1-git-send-email-linus.walleij@stericsson.com>
 <51B75148.5080701@wwwdotorg.org>
 <CACRpkdYQSO0+9tQkS=df-kpL=XL+DpnY1ijp6_Zeg0MvmFujyw@mail.gmail.com>
Message-ID: <51BA1FA6.8070207@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/11/2013 01:53 PM, Linus Walleij wrote:
> On Tue, Jun 11, 2013 at 6:33 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 06/11/2013 02:16 AM, Linus Walleij wrote:
>>> From: Linus Walleij <linus.walleij@linaro.org>
>>>
>>> In addition to the recently introduced pinctrl core
>>> control, the PM runtime pin control for the OMAP platforms
>>> require a fourth state in addtition to the default, idle and
>>> sleep states already handled by the core: an explicit "active"
>>> state. Let's introduce this to the core in addition to the
>>> other states already defined.

...
> Incidentally pinctrl-bindings.txt refers to the states
> "active" and "idle" in the examples, but not "default".
> (git blame tells me you wrote this ;-)

Oops.

> We should probably patch that document a bit to reflect
> the semantics we agree upon here.

Yes!

>> It may be better for struct device, struct platform_driver, or similar,
>> to contain a list of the states that are required by the driver or its
>> binding. That way, the list of states (or states beyond the basic
>> default) is driver-/DT-binding- specific, and custom stuff like this for
>> OMAP wouldn't require explicit code in drivers/base/pinctrl.c, but
>> rather simply iterating over a custom list.
> 
> Hm, I was more out to nail down some common semantics
> here, especially with these helper functions:
> 
> extern int pinctrl_pm_select_default_state(struct device *dev);
> extern int pinctrl_pm_select_active_state(struct device *dev);
> extern int pinctrl_pm_select_sleep_state(struct device *dev);
> extern int pinctrl_pm_select_idle_state(struct device *dev);
> 
> I am intending this to be *all* for the PM consensual states.
> Any other states will be up to the special cases and drivers to
> handle still, I have no intention of retrieveing and caching all
> possible states in the core.

I have this dream that somehow the driver core can one day manage all
resource acquisition, and handle all of deferred probe, etc.
Unfortunately, this probably isn't going to happen in general, since
e.g. DT bindings aren't general enough that code can parse the binding
and automatically find all resources the device will need without
explicit knowledge of the binding definition. No doubt similar problems
exist for all forms of device representation.

So, perhaps this is a pipe dream.

Related to that, if you replaced pinctrl_pm_select_XXX_state(dev) with
pinctrl_pm_select_state(dev, XXX), that'd make it generic enough that if
the core could pre-parse all states, or auto-parse any new state name it
hadn't seen before, then the API could in fact work for any state at all...

> I conjured the following doc patch as a starter:

I didn't really read this much, since I think we need to sort out
exactly which set of core states there are first. Just a small comment
below though:

> diff --git a/Documentation/pinctrl.txt b/Documentation/pinctrl.txt

> +A state-chart diagram would look like this:
> +
> +                +---------+                          +----------+
> +    probe() ->  | default |  -> runtime_suspend() -> | idle     |
> +                |         |  <- runtime_resume()  <- |          |
> +                +---------+                          +----------+
> +                                                        |     ^
> +                                                        |     |
> +                                                  suspend()  resume()
> +                                                        |     |
> +                                                        V     |
> +                                                      +---------+
> +                                                      |  sleep  |
> +                                                      +---------+

"active" isn't in that diagram.
