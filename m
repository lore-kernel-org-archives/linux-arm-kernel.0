From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 28 Jun 2011 16:51:01 -0600
Subject: [RFC 7/8] drivers: introduce rpmsg,
	a remote-processor messaging bus
In-Reply-To: <BANLkTikt08CDJiKNxGF2mKmOhyxHfv21_g@mail.gmail.com>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com>
	<1308640714-17961-8-git-send-email-ohad@wizery.com>
	<20110627222121.GD20865@ponder.secretlab.ca>
	<BANLkTikt08CDJiKNxGF2mKmOhyxHfv21_g@mail.gmail.com>
Message-ID: <BANLkTim+CemMz7A3J94e1UywCNd0r1SABQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2011 at 4:46 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Hi Grant,
>
> On Tue, Jun 28, 2011 at 1:21 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
>>> +static int rpmsg_remove_device(struct device *dev, void *data)
>>> +{
>>> + ? ? struct rpmsg_channel *rpdev = to_rpmsg_channel(dev);
>>> +
>>> + ? ? device_unregister(dev);
>>> +
>>> + ? ? kfree(rpdev);
>>
>> put_device() I think.
>
> Don't think so, we get the device handle from device_for_each_child
> here, which doesn't call get_device (unlike device_find_child).

It's not the device_for_each_child() that you're 'putting' back from
here.  Its the original kref initialization when the device was
created.  Once a device is initialized, it must never be directly
kfree()'d.

g.
