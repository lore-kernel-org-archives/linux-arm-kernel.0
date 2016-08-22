From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 22 Aug 2016 10:42:33 -0600
Subject: [PATCH v3 02/12] mailbox: Add Tegra HSP driver
In-Reply-To: <20160822141728.GF17367@ulmo.ba.sec>
References: <20160819173233.13260-1-thierry.reding@gmail.com>
 <20160819173233.13260-3-thierry.reding@gmail.com>
 <13954058.6YHDe1jCOJ@wuerfel> <20160822141728.GF17367@ulmo.ba.sec>
Message-ID: <0a70a07d-9cc6-cd35-98a8-d55c2ffdb49d@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/22/2016 08:17 AM, Thierry Reding wrote:
> On Mon, Aug 22, 2016 at 03:43:23PM +0200, Arnd Bergmann wrote:
>> On Friday, August 19, 2016 7:32:23 PM CEST Thierry Reding wrote:
>>> +static int tegra_hsp_doorbell_send_data(struct tegra_hsp_channel *channel,
>>> +                                       void *data)
>>> +{
>>> +       tegra_hsp_channel_writel(channel, 1, HSP_DB_TRIGGER);
>>> +
>>> +       return 0;
>>> +}
>>>
>>
>> It seems very odd that you don't write the data at all but just trigger
>> the communication here. My interpretation is that you bypass
>> the mailbox infrastructure for the actual message, and instead reimplement
>> it on top of the mailbox infrastructure as part of the bpmp driver.
>>
>> Why not expose the bpmp itself as the mailbox here?
>
> My understanding is that doorbell doesn't provide any means to transfer
> data. It merely signals the availability of data. It is up to a use-case
> specific implementation to arrange for the transport of data.

Yes, the doorbell doesn't transfer any data.

> BPMP implements a shmem-based protocol and uses the doorbell merely as a
> mechanism for the BPMP and CPU to signal each other when data is ready.
>
> Exposing the BPMP as the mailbox could possibly be done, but it would
> implement a fairly large software layer in the mailbox system which is
> targetted primarily at simple mailbox hardware that exchanges small
> amounts of data (usually fitting into 32 bits). mailbox-sti is another
> driver that uses the framework only to signal, so this doesn't seem to
> be a mechanism exclusive to Tegra.

I also don't think that in-memory IPC mechanisms are what the mailbox 
subsystem is all about; it's about pure HW mechanisms that transfer data.
