From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Wed, 18 Mar 2015 18:26:14 +0530
Subject: [PATCH v7 2/7] mailbox: arm_mhu: add driver for ARM MHU controller
In-Reply-To: <55094BEF.9060006@arm.com>
References: <1425466367-30556-1-git-send-email-vincent.yang@socionext.com>
 <1425466884-30648-1-git-send-email-vincent.yang@socionext.com>
 <55094BEF.9060006@arm.com>
Message-ID: <CABb+yY2woK6qWbrgPGRBRXJqJdf=1HxE_-Am-SY1_Uf_dNgTew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 18, 2015 at 3:27 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> Hi Vincent,
>
> I see that this driver is queued but most of my earlier comments were
> not addressed.
>
Some of your comments have been addressed as changes and some as replies.

> *No ACK from DT binding maintainers too*.
>
Yeah it would have been great to have some ack. It has been many
months now, but I see its not uncommon for bindings go in via
maintainers. I assume folks find it just normal.


>> +++ b/Documentation/devicetree/bindings/mailbox/arm-mhu.txt
>> @@ -0,0 +1,43 @@
>> +ARM MHU Mailbox Driver
>> +======================
>> +
>> +The ARM's Message-Handling-Unit (MHU) is a mailbox controller that has
>> +3 independent channels/links to communicate with remote processor(s).
>> + MHU links are hardwired on a platform. A link raises interrupt for any
>
>
> As I had mentioned before it's just one implementation, the IP had
> provision bi-directional interrupts and the binding *has to consider*
> that instead of having to workaround that later.
>
I will reply in yet another way.... the spec I have don't mention that
(and it makes sense) and your platform doesn't do that either. I would
have had to do something about it, had there been such a weird setup,
but there's none known.

 So let us please avoid getting into bikeshedding discussion yet
again. Otherwise almost every binding is broken because there could
always be some platform that does weird things with irqs.

>> +The last channel is specified to be a 'Secure' resource, hence can't be
>> +used by Linux running NS.
>
> Correct so drop the support for secure channel until the first user
> comes up.
>
In your last post you said:
  "Sorry my statement was not clear, I wanted to ask you to add that info
to the binding."
  Not that it makes sense to say the obvious, I added it just to
address your comment.

> I am worried it might generate abort if someone tries to
> access it in ARM64 which always runs in non-secure.
>
Abort should have happened years ago if someone _tries_ to access a
secure resource from non-secure mode ;)
How do you protect such people from "trying to" dereference NULL
pointers?  (you made me repeat Nth time).

>> +
>> +static struct amba_id mhu_ids[] = {
>> +       {
>> +               .id     = 0x1bb098,
>
>
> As I mentioned couple of times this is broken. Please refer my earlier mail
> for details. You are skipping a field to compare which incorrect.
> You are just trying to get it working with existing AMBA driver without any
> changes matching the IDs partially.
>
I did not miss your last mail. Let me try to reply in even simpler
terms... PID[0,3] identification is fine grained enough. If/when we
have some platform with non-ARM MHU, we could catch that in this
driver. Most likely even then the reg-map won't change drastically, if
at all. So we could ignore the PID4, otherwise we check PID4 in this
driver and adapt the behavior.

-Jassi
