From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 7 Jul 2017 18:39:24 +0100
Subject: [PATCH 3/9] firmware: arm_scmi: add basic driver infrastructure
 for SCMI
In-Reply-To: <1499446341-5956-1-git-send-email-jaswinder.singh@linaro.org>
References: <1498492513-29771-4-git-send-email-sudeep.holla@arm.com>
 <1499446341-5956-1-git-send-email-jaswinder.singh@linaro.org>
Message-ID: <5f2e4f3c-297b-c5f8-9244-399c1c4e2c21@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/07/17 17:52, Jassi Brar wrote:
> Hi Arnd, Hi Rob, Hi Mark,
> 
> [CC'ing only those who I have the email id of]
> 
>> +/**
>> + * scmi_do_xfer() - Do one transfer
>> + *
>> + * @info: Pointer to SCMI entity information
>> + * @xfer: Transfer to initiate and wait for response
>> + *
>> + * Return: -ETIMEDOUT in case of no response, if transmit error,
>> + *   return corresponding error, else if all goes well,
>> + *   return 0.
>> + */
>> +int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
>> +{
>> +	int ret;
>> +	int timeout;
>> +	struct scmi_info *info = handle_to_scmi_info(handle);
>> +	struct device *dev = info->dev;
>> +
>> +	ret = mbox_send_message(info->tx_chan, xfer);
>> +
>>
> The api is
> 
>     int mbox_send_message(struct mbox_chan *chan, void *mssg)
> 
> where each controller driver defines its own format in which it accepts
> the 'mssg' to be transmitted.
> 

Yes they can continue that, but SCMI just doesn't depend on that.

> For example :-
> ti_msgmgr_send_data(struct mbox_chan *, struct ti_msgmgr_message *)
> rockchip_mbox_send_data(struct mbox_chan *, struct rockchip_mbox_msg *)
> ....and so on...  you get the idea.
> 

Yes I am aware of that.

> Some controller driver may ignore the 'mssg' because only an interrupt line
> is shared with the remote and not some register/fifo.
> For example,
>   sti_mbox_send_data(struct mbox_chan *, void *ignored)
> 

Exactly, now with SCMI, every controller *can do* that, as we just care
about the signaling which in other terms I have so far referred as
"doorbell". The data passed should not be used for any other purpose
as there's no need to even by the remote firmware implementing SCMI.

If you read the SCMI specification, it's designed to avoid all such
issues with wide variety of mailbox controller we have in the wild.
And hence all the command and other information are passed in the shared
memory.

> Out of 14 controller drivers today, this SCMI implementation will work with
> only 5 (and that too by abusing the api).

What do you mean by abusing the API ?

> The other 9 controllers (and many
> in future) are perfectly able to support SCMI (its just another protocol).

Exactly, if and only if they adhere to the specification.

> All we need is what the SCMI specification calls "Transport Layer".
> Of course that will be a thin platform/controller specific code that will
> encapsulate the 'struct scmi_xfer *xfer' from SCMI, into controller specified
> format and actually call the mbox_send_message().

OK, if platform had to send some platform specific data, I agree. But
can you point me from the SCPI specification the need for the platforms
to do that. That's the whole point. Transport is just a doorbell nothing
more.

You are trying to fit the existing platform implementation into SCMI
which won't work.

E.g. if TI/Rockchip implements SCMI, they can continue using these
drivers as along as it does the job of "ringing the doorbell".

They may be passing some data today because their existing remote
firmware expects it. With SCMI, they don't have to. These existing
drivers are doing additional job in the current form: passing some data
along with triggering the remote doorbell. We just need latter in SCMI
case as we don't need any data in the transport as it's all part of shmem.

Why do you think that won't work ? Remember all the platform specific
stuff(if platform implement own protocols) in SCMI is moved to the
shared memory and transport just needs to do "doorbell". So I disagree
with your concern unless I am missing something.

> 
>  To achieve that, we can either do similar to what platforms with DWC3
> do - generic dwc3 child node of platform specific parent node. Or we can have
> the SCMI protocol implemented as a library that platforms can init and use.
> Or any other better way.
> 
>  I just think it is a bad idea to rule out all but one classes of mailbox controllers.
> 

Definitely neither SCMI specification nor SCMI driver is ruling out any
class of mailbox controllers as long as there are capable of signaling
the other end that "hey look you have something to check in shared
memory" which I think is the case with most of the controllers.

To be honest this whole mailbox framework is somewhat complex for simple
doorbell kind of this, but hey I am not complaining ;).

-- 
Regards,
Sudeep
