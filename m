From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 6 Nov 2018 17:06:31 +0100
Subject: [PATCH RFC 09/18] staging: vchiq_core: do not initialize
 semaphores twice
In-Reply-To: <ddef268b97543abc9de05842b92e1fc5f0134de8.camel@suse.de>
References: <20181026134813.7775-1-nsaenzjulienne@suse.de>
 <20181026134813.7775-10-nsaenzjulienne@suse.de>
 <1781917429.4071.1540759539282@email.ionos.de>
 <ddef268b97543abc9de05842b92e1fc5f0134de8.camel@suse.de>
Message-ID: <9366d835-a291-2770-4409-b88ea1a155e2@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 06.11.18 um 16:41 schrieb Nicolas Saenz Julienne:
> Hi Stefan,
> thanks for spending the time reviewing the code. I took note of the
> rest of comments.
>
> On Sun, 2018-10-28 at 21:45 +0100, Stefan Wahren wrote:
>> Hi Nicolas,
>>
>>> Nicolas Saenz Julienne <nsaenzjulienne@suse.de> hat am 26. Oktober
>>> 2018 um 15:48 geschrieben:
>>>
>>>
>>> vchiq_init_state() initialises a series of semaphores to then call
>>> remote_event_create() on the same semaphores, which initializes
>>> them
>>> again.
>> i would prefer to have all init stuff at one place in
>> vchiq_init_state() and drop this ugliness from remote_event_create()
>> instead. Is this possible?
> As I'm sure you're aware of, REMOTE_EVENT_T is shared between the CPU
> and VC4, which can't be expanded. And since storing a pointer is out of
> question because of arm64, I can only think of storing an index to an
> array of completions in the shared structure instead of the pointer
> magic implemented right now. It would be a little more explicit. Then
> we could completely decouple both initializations. I'm not sure if it's
> similar to what you had in mind. 

I don't think so, this was my intention:

?static inline void
?remote_event_create(VCHIQ_STATE_T *state, REMOTE_EVENT_T *event)
?{
??? event->armed = 0;
??? /* Don't clear the 'fired' flag because it may already have been set
??? ** by the other side. */
-??? sema_init((struct semaphore *)((char *)state + event->event), 0);
?}


>
> On a semi-related topic, I'm curious to know why these shared
> structures aren't set with the "__packed" preprocessor macro. Any
> ideas? As fas as I've been told, in general, the compiler may reorder
> or add unexpected padding to any structure. Which would be very bad in
> this case.

This would be better, but i assume the firmware side uses the same
source code. So using __packed only on ARM side could also break :-(

>
> Regards,
> Nicolas
