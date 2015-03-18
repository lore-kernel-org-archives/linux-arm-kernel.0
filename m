From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 18 Mar 2015 14:08:35 +0000
Subject: [PATCH v7 2/7] mailbox: arm_mhu: add driver for ARM MHU controller
In-Reply-To: <CABb+yY2woK6qWbrgPGRBRXJqJdf=1HxE_-Am-SY1_Uf_dNgTew@mail.gmail.com>
References: <1425466367-30556-1-git-send-email-vincent.yang@socionext.com>	<1425466884-30648-1-git-send-email-vincent.yang@socionext.com>	<55094BEF.9060006@arm.com>
 <CABb+yY2woK6qWbrgPGRBRXJqJdf=1HxE_-Am-SY1_Uf_dNgTew@mail.gmail.com>
Message-ID: <550986E3.8030605@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 18/03/15 12:56, Jassi Brar wrote:
> On Wed, Mar 18, 2015 at 3:27 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> Hi Vincent,
>>
>> I see that this driver is queued but most of my earlier comments were
>> not addressed.
>>
> Some of your comments have been addressed as changes and some as replies.
>
>> *No ACK from DT binding maintainers too*.
>>
> Yeah it would have been great to have some ack. It has been many
> months now, but I see its not uncommon for bindings go in via
> maintainers. I assume folks find it just normal.
>

OK, but I have one concern in the binding as mentioned previous and
again as below.

>>> +++ b/Documentation/devicetree/bindings/mailbox/arm-mhu.txt
>>> @@ -0,0 +1,43 @@
>>> +ARM MHU Mailbox Driver
>>> +======================
>>> +
>>> +The ARM's Message-Handling-Unit (MHU) is a mailbox controller that has
>>> +3 independent channels/links to communicate with remote processor(s).
>>> + MHU links are hardwired on a platform. A link raises interrupt for any
>>
>>
>> As I had mentioned before it's just one implementation, the IP had
>> provision bi-directional interrupts and the binding *has to consider*
>> that instead of having to workaround that later.
>>
> I will reply in yet another way.... the spec I have don't mention that
> (and it makes sense) and your platform doesn't do that either. I would
> have had to do something about it, had there been such a weird setup,
> but there's none known.
>

Not just weird setup, even extending Tx support with this binding is not
straight forward.

Simple example:
Today you have:
		interrupts = <0 36 4>, /* LP-NonSecure */
			     <0 35 4>, /* HP-NonSecure */
			     <0 37 4>; /* Secure */

I don't want to specify Secure IRQ on my platform, which should be fine.
In future a variant of that platform gets Tx interrupts, then I will add
something like below:
		interrupts = <0 36 4>, /* LP-NonSecure Rx */
			     <0 35 4>, /* HP-NonSecure Rx */
			     <0 39 4>, /* LP-NonSecure Tx */
			     <0 38 4>, /* HP-NonSecure Tx */

Now how will we handle this ?

I am just suggesting to use interrupt-names so that we don't depend on
ordering in DT implicitly from first by fixing the binding.

>   So let us please avoid getting into bikeshedding discussion yet
> again. Otherwise almost every binding is broken because there could
> always be some platform that does weird things with irqs.
>

Sorry I don't buy that given that using interrupt-names simplifies
things and also helps to hand any such cases.

>>> +The last channel is specified to be a 'Secure' resource, hence can't be
>>> +used by Linux running NS.
>>
>> Correct so drop the support for secure channel until the first user
>> comes up.
>>
> In your last post you said:
>    "Sorry my statement was not clear, I wanted to ask you to add that info
> to the binding."
>    Not that it makes sense to say the obvious, I added it just to
> address your comment.
>
>> I am worried it might generate abort if someone tries to
>> access it in ARM64 which always runs in non-secure.
>>
> Abort should have happened years ago if someone _tries_ to access a
> secure resource from non-secure mode ;)
> How do you protect such people from "trying to" dereference NULL
> pointers?  (you made me repeat Nth time).
>

When the general practice everywhere in the kernel is to avoid secure
accesses *unless and until absolutely necessary*, I don't understand
*why exactly we need the exception here* ? I am OK if you add that
justification with the first user of that channel. We have seen several
cases/issues around that and I am just looking for a strong reason to
add secure channel support here.

>>> +
>>> +static struct amba_id mhu_ids[] = {
>>> +       {
>>> +               .id     = 0x1bb098,
>>
>>
>> As I mentioned couple of times this is broken. Please refer my earlier mail
>> for details. You are skipping a field to compare which incorrect.
>> You are just trying to get it working with existing AMBA driver without any
>> changes matching the IDs partially.
>>
> I did not miss your last mail. Let me try to reply in even simpler
> terms... PID[0,3] identification is fine grained enough. If/when we
> have some platform with non-ARM MHU, we could catch that in this
> driver. Most likely even then the reg-map won't change drastically, if
> at all. So we could ignore the PID4, otherwise we check PID4 in this
> driver and adapt the behavior.

I am just looking for ARM MHU implementation, not any non-ARM MHU.
If look at the MHU spec[1], excerpts below:

PID_4 Register

[31:8]	-	Reserved. Read as zero.
[7:4]	SIZE	Indicates the log2 of the number of 4KB blocks that the 
interface occupies. Set to 0x0.
[3:0]	DES_2	JEP106 continuation code that identifies the designer. Set 
to 0x4 for ARM.

PID_1 Register

[31:8]	-	Reserved. Read as zero.
[7:4]	DES_0	Bits [3:0] of the JEP Identity. Set to 0xB for ARM.
[3:0]	PART_1	Bits [11:8] of the part number. Set to 0x0.

Now by skipping PID4 DES_2 part, you are not comparing the designer
correctly. It may be OK to fix in the driver as you mentioned.
Not sure if it's better to fix AMBA, or just don't use AMBA for
IP with JEP106 code. I don't have any strong opinion there.

Regards,
Sudeep

[1] 
http://infocenter.arm.com/help/topic/com.arm.doc.ddi0515b/CHDBFACE.html#id5278622
