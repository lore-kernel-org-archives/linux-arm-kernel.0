From: balbi@ti.com (Felipe Balbi)
Date: Tue, 16 Jul 2013 12:35:41 +0300
Subject: [PATCH 3/4] pinctrl: Add support for additional dynamic states
In-Reply-To: <20130716090536.5541.36289.stgit@localhost>
References: <20130716090310.5541.36777.stgit@localhost>
 <20130716090536.5541.36289.stgit@localhost>
Message-ID: <20130716093541.GK8880@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jul 16, 2013 at 02:05:36AM -0700, Tony Lindgren wrote:
> +int pinctrl_check_dynamic(struct device *dev, struct pinctrl_state *st1,
> +			  struct pinctrl_state *st2)
> +{
> +	struct pinctrl_setting *s1, *s2;
> +
> +	list_for_each_entry(s1, &st1->settings, node) {
> +		struct pinctrl_dev *pctldev1;
> +		const struct pinctrl_ops *pctlops1;
> +		const unsigned *pins1;
> +		unsigned num_pins1;
> +		int res;
> +
> +		if (s1->type != PIN_MAP_TYPE_MUX_GROUP)
> +			continue;
> +
> +		pctldev1 = s1->pctldev;
> +		pctlops1 = pctldev1->desc->pctlops;
> +		res = pctlops1->get_group_pins(pctldev1, s1->data.mux.group,
> +					       &pins1, &num_pins1);
> +		if (res) {
> +			dev_dbg(dev, "could not get state1 group pins\n");
> +			return -EINVAL;
> +		}
> +
> +		list_for_each_entry(s2, &st2->settings, node) {
> +			struct pinctrl_dev *pctldev2;
> +			const struct pinctrl_ops *pctlops2;
> +			const unsigned *pins2;
> +			unsigned num_pins2;
> +			int i, j, found = 0;
> +
> +			if (s2->type != PIN_MAP_TYPE_MUX_GROUP)
> +				continue;
> +
> +			pctldev2 = s2->pctldev;
> +			if (pctldev1 != pctldev2) {
> +				dev_dbg(dev, "pctldev must be the same for states\n");
> +				return -EINVAL;
> +			}
> +			pctlops2 = pctldev2->desc->pctlops;
> +			res = pctlops2->get_group_pins(pctldev2,
> +						       s2->data.mux.group,
> +						       &pins2, &num_pins2);
> +			if (res) {
> +				dev_dbg(dev, "could not get state2 group pins\n");
> +				return -EINVAL;
> +			}
> +
> +			for (i = 0; i < num_pins1; i++) {
> +				int pin1 = pins1[i];
> +
> +				for (j = 0; j < num_pins2; j++) {
> +					int pin2 = pins2[j];
> +
> +					if (pin1 == pin2) {
> +						found++;
> +						break;
> +					}
> +				}
> +			}

4 levels of nested loops ? Isn't this way too much ? OTOH, it points to
the fact that, perhaps, a list isn't the best data structure for
pinctrl ??

Or perhaps you could just assume that if num_pins1 == num_pins2 it's
enough ? But that will, likely, leave some uncovered corners...

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130716/bb3331b7/attachment.sig>
