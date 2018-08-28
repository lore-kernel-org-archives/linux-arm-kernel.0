From: a.hajda@samsung.com (Andrzej Hajda)
Date: Tue, 28 Aug 2018 09:31:53 +0200
Subject: [PATCH v2 4/7] drm/i2c: tda998x: convert to bridge driver
In-Reply-To: <20180827175947.GE30658@n2100.armlinux.org.uk>
References: <20180730164137.GD17271@n2100.armlinux.org.uk>
 <CGME20180731072333epcas3p152812eff8bdb2390ea482a4a20d34438@epcas3p1.samsung.com>
 <E1fkBFV-00048s-O2@rmk-PC.armlinux.org.uk>
 <20180827161601eucas1p2951c1ce0eeeabbcf9d190d7dca28c91c~OyfFOhdDv1363313633eucas1p2b@eucas1p2.samsung.com>
 <20180827175947.GE30658@n2100.armlinux.org.uk>
Message-ID: <20180828073156eucas1p21e13ba5d7702e6147a05b9750c8eb054~O__x-ibC70308603086eucas1p2B@eucas1p2.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27.08.2018 19:59, Russell King - ARM Linux wrote:
> Hi Andrzej,
>
> On Mon, Aug 27, 2018 at 06:15:59PM +0200, Andrzej Hajda wrote:
>> On 30.07.2018 18:42, Russell King wrote:
>>>  static void tda998x_destroy(struct tda998x_priv *priv)
>>>  {
>>> +	drm_bridge_remove(&priv->bridge);
>>> +
>>>  	/* disable all IRQs and free the IRQ handler */
>>>  	cec_write(priv, REG_CEC_RXSHPDINTENA, 0);
>>>  	reg_clear(priv, REG_INT_FLAGS_2, INT_FLAGS_2_EDID_BLK_RD);
>>> @@ -1650,6 +1663,7 @@ static int tda998x_create(struct i2c_client *client, struct tda998x_priv *priv)
>>>  	mutex_init(&priv->mutex);	/* protect the page access */
>>>  	mutex_init(&priv->audio_mutex); /* protect access from audio thread */
>>>  	mutex_init(&priv->edid_mutex);
>>> +	INIT_LIST_HEAD(&priv->bridge.list);
>> This line can be probably removed, unless there is a reason I am not
>> aware of.
> The addition above of drm_bridge_remove() to tda998x_destroy() means
> that we end up calling this function in the error cleanup path.  This
> avoids unnecessary complexity with lots of different gotos - tda998x
> has had a long history of not cleaning up stuff properly.

1. bridge.list is/should be a private field of drm_bridge framework, so
it's direct usage in driver looks like layer violation.
2. Calling drm_bridge_remove() without drm_bridge_add() is not strictly
forbidden, but at least looks very suspicious. Even if current
implementation tolerates it, it can change in the future.

Neither argument is a blocker IMO so if you prefer to stay with current
solution please add a comment in the code explaining why do you
initializes list field, the code at first sight looks suspicious.

> devm interfaces for bridge do not help avoid that - devm stuff only
> works if everything that is registered previously is cleaned up via
> devm mechanisms to ensure that a device's interface becomes unavailable
> before stuff (eg, edid timers, detect work) is started to be cleaned up.
> Otherwise, there's a chance of this stuff being triggered during
> tear-down.
>
>>> +static int tda998x_bind(struct device *dev, struct device *master, void *data)
>>> +{
>>> +	struct i2c_client *client = to_i2c_client(dev);
>>> +	struct drm_device *drm = data;
>>> +	struct tda998x_priv *priv;
>>> +	int ret;
>>> +
>>> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>>> +	if (!priv)
>>> +		return -ENOMEM;
>>> +
>>> +	dev_set_drvdata(dev, priv);
>>> +
>>> +	ret = tda998x_create(client, priv);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = tda998x_encoder_init(dev, drm);
>>> +	if (ret) {
>>> +		tda998x_destroy(priv);
>>> +		return ret;
>>> +	}
>>> +	return 0;
>> It could be replaced by:
>> ??? ret = tda998x_encoder_init(dev, drm);
>> ??? if (ret)
>> ??? ??? tda998x_destroy(priv);
>> ??? return ret;
>>
>> but this is probably matter of taste.
> It's not clear to me what "It" is - I think you're suggesting combining
> tda998x_create() and tda998x_encoder_init() ?

No, just simplifying error path.

>
> The code is structured this way to make the following patches easier -
> there is no point of combining things only to have to then break them
> apart again in a later patch.  Please see patch 7, where tda998x_create()
> moves out of this function, where exactly this happens.

OK. As I said: up to you.

>
>> Moreover I guess priv->is_on could be removed if enable/disable
>> callbacks are called only by drm_core, but this is for another patch.
> Is it guaranteed that a bridge ->enable or ->disable callback won't be
> called twice, even for legacy drivers?  I think atomic guarantees this
> but I don't think it's guaranteed for legacy drivers.
>
> I'm guessing Rob had a reason why he added the check when he originally
> created the driver (encoder ->dpms can be called for the same dpms
> state multiple times?)
>
OK, my guess was incorrect.


Regards

Andrzej
