From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 19 Mar 2015 11:20:25 +0530
Subject: [PATCH 3/3] mailbox: Add support for ST's Mailbox IP
In-Reply-To: <20150318153421.GP3318@x1>
References: <1425379283-1567-1-git-send-email-lee.jones@linaro.org>
 <1425379283-1567-4-git-send-email-lee.jones@linaro.org>
 <3926609.Ff6LCkuuMX@wuerfel>
 <CAJe_ZhdjPa3C_TUDAPA3fS3K83FGB-GaAjVBjtsow2mp5h8NRw@mail.gmail.com>
 <20150318131722.GN3318@x1>
 <CABb+yY0wmy+oYUsVkStrMVmfGjvedDPn+wsN_yjvdMRQoVEHOg@mail.gmail.com>
 <20150318153421.GP3318@x1>
Message-ID: <CABb+yY0HufMEDy7ANj8KV0hamvM-Tgy4GBkwD73wm3DMumcbaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 18, 2015 at 9:04 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Wed, 18 Mar 2015, Jassi Brar wrote:
>
>> On Wed, Mar 18, 2015 at 6:47 PM, Lee Jones <lee.jones@linaro.org> wrote:
>> > On Tue, 03 Mar 2015, Jassi Brar wrote:
>> >
>> >> On 3 March 2015 at 17:04, Arnd Bergmann <arnd@arndb.de> wrote:
>> >> > On Tuesday 03 March 2015 10:41:23 Lee Jones wrote:
>> >> >> +
>> >> >> +/*
>> >> >> + * struct sti_mbox_msg - sti mailbox message description
>> >> >> + * @dsize:             data payload size
>> >> >> + * @pdata:             message data payload
>> >> >> + */
>> >> >> +struct sti_mbox_msg {
>> >> >> +       u32             dsize;
>> >> >> +       u8              *pdata;
>> >> >> +};
>> >> >
>> >> > As mentioned in another thread, we may just want to add a 'size'
>> >> > argument to the message send function, and a default helper for
>> >> > messages with size of 32 bits.
>> >> >
>> >> Case-a) 'size' is a member of the payload structure itself
>> >>     The extra 'size' argument would only be used for sanity check.
>> >>     This driver seems so. Lee, can you not do without 'dsize'?
>> >>
>> >> Case-b) 'size' is not a member of payload structure:
>> >>      b1)  payload is fixed length, that is 'size' := sizeof(struct my_payload)
>> >>             Here the size argument is redundant.
>> >>
>> >>      b2)  payload length varies
>> >>             This case is highly unlikely because there would be no way
>> >> for remote to know how many bytes to read as the payload. Not to mean
>> >> we can't do without the 'size' argument.
>> >>
>> >> Your opinion has huge weight, but I would like to be enlightened
>> >> before agreeing.
>> >
>> > Let's simplify this.
>> >
>> > If you want to have varying length payloads, you have to carry the
>> > size in the payload.  If you wish to force fixed size payloads, then
>> > you may do without a size segment.
>> >
>> > Do you really want to force all users of Mailbox to use fixed size
>> > payloads?
>> >
>> No. I only observed the fact that every known mailbox controller
>> driver already has a way to figure out the payload length because
>> either the protocol uses fixed length payloads or has the 'size' field
>> in every payload.
>> I am yet to see a platform that uses both, then the 'size' argument
>> will be helpful but still not necessary.
>
> I see.  So your real concern is that controllers shouldn't have two
> means of obtaining size.
>
I think right now there's not much need to expand the api for 'u32'
sized payloads.

> Arnd's idea of placing the message size as part of the send_message()
> call is fine, but it's still going to end up in the payload isn't it?
>
... or it will be implied by sizeof(struct my_packet) if the protocol
has finite set of payloads.

> And what about receiving?
>
Similar to sending - controller driver passes pointer to RX buffer
which the client parses. Remember the protocol would already have a
way to communicate payload length.
