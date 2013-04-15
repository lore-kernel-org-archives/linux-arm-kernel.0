From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Mon, 15 Apr 2013 12:12:39 +0530
Subject: Query on pinctrl usage for DT nodes
In-Reply-To: <CA+V-a8syL4YCddiz5W4dEhAhQjFo07_Hg+J6TN94cuPV7SQGag@mail.gmail.com>
References: <CA+V-a8uiPwsAD--OHFAE=i2ed+-wbXm4p2deZXr92+Zv6GDS1w@mail.gmail.com>
 <515C5C76.3080009@wwwdotorg.org>
 <CA+V-a8t3wtP77DdeUoQHKMjAuWmV+ude+1J3UjJmMTqobgStjA@mail.gmail.com>
 <5162FD4A.1030909@wwwdotorg.org>
 <CA+V-a8vwdCkyMqiynj5BodXbjwJ=e4qNb-29FhLweqbjc7DBQA@mail.gmail.com>
 <5165A22B.4070200@wwwdotorg.org> <20130410203408.GP10155@atomide.com>
 <CA+V-a8syL4YCddiz5W4dEhAhQjFo07_Hg+J6TN94cuPV7SQGag@mail.gmail.com>
Message-ID: <CA+V-a8tmOd_r3Ry=udMeioFq3JuNXqNvWmhLhp-2XLyAy+PFCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Mon, Apr 15, 2013 at 10:39 AM, Prabhakar Lad
<prabhakar.csengg@gmail.com> wrote:
> Hi Tony,
>
> On Thu, Apr 11, 2013 at 2:04 AM, Tony Lindgren <tony@atomide.com> wrote:
>> * Stephen Warren <swarren@wwwdotorg.org> [130410 10:37]:
>>> On 04/10/2013 02:12 AM, Prabhakar Lad wrote:
>>> ...
>>> > Following is the proposed fix/hack let me know if its OK.
>>> >
>>> > Regards,
>>> > --Prabhakar
>>> >
>>> > ->>>>>>>>>>>>>>>>>>>
>>> >
>>> > diff --git a/drivers/pinctrl/core.h b/drivers/pinctrl/core.h
>>> > index ee72f1f..78fb42d 100644
>>> > --- a/drivers/pinctrl/core.h
>>> > +++ b/drivers/pinctrl/core.h
>>> > @@ -46,6 +46,7 @@ struct pinctrl_dev {
>>> >         struct pinctrl *p;
>>> >         struct pinctrl_state *hog_default;
>>> >         struct pinctrl_state *hog_sleep;
>>> > +       bool bits_per_mux;
>>>
>>> This clearly isn't correct; any change to solve this problem should only
>>> touch the internals of the pinctrl-single driver, not the pinctrl core.
>>
>> Yeah how about just change the pintctrl-single,bits register
>> naming to be register + bit?  Something like 0xdeadbeef.0 and
>> 0xdeadbeef.1 and so on.
>>
> How and where the changing the register naming would help ?
>
No matter we change the register name, it would fail in pin_request()
function, see the following code snippet

static int pin_request(struct pinctrl_dev *pctldev,
		       int pin, const char *owner,
		       struct pinctrl_gpio_range *gpio_range)
{
	struct pin_desc *desc;
	const struct pinmux_ops *ops = pctldev->desc->pmxops;
	int status = -EINVAL;

	desc = pin_desc_get(pctldev, pin);
	if (desc == NULL) {
		dev_err(pctldev->dev,
			"pin %d is not registered so it cannot be requested\n",
			pin);
		goto out;
	}

	dev_dbg(pctldev->dev, "request pin %d (%s) for %s\n",
		pin, desc->name, owner);

	if (gpio_range) {
		/* There's no need to support multiple GPIO requests */
		if (desc->gpio_owner) {
			dev_err(pctldev->dev,
				"pin %s already requested by %s; cannot claim for %s\n",
				desc->name, desc->gpio_owner, owner);
			goto out;
		}

		desc->gpio_owner = owner;
	} else {
		if (desc->mux_usecount && strcmp(desc->mux_owner, owner)) {
			dev_err(pctldev->dev,
				"pin %s already requested by %s; cannot claim for %s\n",
				desc->name, desc->mux_owner, owner);
			goto out;
		}

		desc->mux_usecount++;
		if (desc->mux_usecount > 1)
			return 0;

		desc->mux_owner = owner;
	}

      ...........
}

Since desc->mux_owner and owner would obviously differ.

Regards,
--Prabhakar

> Regards,
> --Prabhakar
>
>> Regards,
>>
>> Tony
