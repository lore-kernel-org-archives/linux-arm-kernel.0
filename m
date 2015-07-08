From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Wed, 8 Jul 2015 16:31:37 +0300
Subject: [PATCH 01/10] i2c: add and export of_get_i2c_adapter_by_node()
 interface
In-Reply-To: <20150708131140.GA12791@ulmo.nvidia.com>
References: <1436360095-9065-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1436360352-9181-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <20150708131140.GA12791@ulmo.nvidia.com>
Message-ID: <559D2639.1030706@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry,

On 08.07.2015 16:11, Thierry Reding wrote:
> On Wed, Jul 08, 2015 at 03:59:12PM +0300, Vladimir Zapolskiy wrote:
>> of_find_i2c_adapter_by_node() call requires quite often missing
>> put_device(), and i2c_put_adapter() releases a device locked by
>> i2c_get_adapter() only. In general module_put(adapter->owner) and
>> put_device(dev) are not interchangeable.
>>
>> This is a common error reproduction scenario as a result of the
>> misusage described above (for clearness this is run on iMX6 platform
>> with HDMI and I2C bus drivers compiled as kernel modules):
>>
>>     root at mx6q:~# lsmod | grep i2c
>>     i2c_imx                10213  0
>>     root at mx6q:~# lsmod | grep dw_hdmi_imx
>>     dw_hdmi_imx             3631  0
>>     dw_hdmi                11846  1 dw_hdmi_imx
>>     imxdrm                  8674  3 dw_hdmi_imx,imx_ipuv3_crtc,imx_ldb
>>     drm_kms_helper        113765  5 dw_hdmi,imxdrm,imx_ipuv3_crtc,imx_ldb
>>     root at mx6q:~# rmmod dw_hdmi_imx
>>     root at mx6q:~# lsmod | grep i2c
>>     i2c_imx                10213  -1
>>
>>                                  ^^^^^
>>
>>     root at mx6q:~# rmmod i2c_imx
>>     rmmod: ERROR: Module i2c_imx is in use
>>
>> To fix existing users of these interfaces and to avoid any further
>> confusion and misusage in future, add one more interface
>> of_get_i2c_adapter_by_node(), it is similar to i2c_get_adapter() in
>> sense that an I2C bus device driver found and locked by user can be
>> correctly unlocked by i2c_put_adapter().
>>
>> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
>> ---
>> The change is based on RFC http://www.spinics.net/lists/linux-i2c/msg20257.html
>>
>> * added new exported function declaration in include/linux/i2c.h
>> * added put_device(dev) call right inside of_get_i2c_adapter_by_node()
>> * corrected authorship of the change
>>
>>  drivers/i2c/i2c-core.c | 20 ++++++++++++++++++++
>>  include/linux/i2c.h    |  6 ++++++
>>  2 files changed, 26 insertions(+)
>>
>> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
>> index 069a41f..0d902ab 100644
>> --- a/drivers/i2c/i2c-core.c
>> +++ b/drivers/i2c/i2c-core.c
>> @@ -1356,6 +1356,26 @@ struct i2c_adapter *of_find_i2c_adapter_by_node(struct device_node *node)
>>  	return i2c_verify_adapter(dev);
>>  }
>>  EXPORT_SYMBOL(of_find_i2c_adapter_by_node);
>> +
>> +struct i2c_adapter *of_get_i2c_adapter_by_node(struct device_node *node)
>> +{
>> +	struct device *dev;
>> +	struct i2c_adapter *adapter;
>> +
>> +	dev = bus_find_device(&i2c_bus_type, NULL, node,
>> +			      of_dev_node_match);
>> +	if (!dev)
>> +		return NULL;
>> +
>> +	adapter = i2c_verify_adapter(dev);
>> +	if (adapter && !try_module_get(adapter->owner))
>> +		adapter = NULL;
>> +
>> +	put_device(dev);
> 
> I don't think this is correct. Users still need to keep a reference to
> the device, otherwise it can simply disappear even if the module stays
> around (think sysfs bind/unbind attributes).
> 
> Looking at i2c_put_adapter() it seems like it would need to do more than
> just drop the module reference. Then again, that probably means that we
> need to add a get_device() somewhere in i2c_get_adapter() to balance the
> put_device() in i2c_put_adapter().

it makes sense for me, thanks for momentary review.

I'm hesitating to add put_device(dev) to i2c_put_adapter() etc. in this
series though. After development and testing I would like to send
another preceding independent change updating i2c_get_adapter(),
i2c_put_adapter() and clients (or if you wish you can do it), then I'll
rebase 01/10 on top of it, the rest most probably is unchanged.

--
With best wishes,
Vladimir
