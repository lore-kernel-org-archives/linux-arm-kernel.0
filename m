From: nsaenzjulienne@suse.de (Nicolas Saenz Julienne)
Date: Tue, 06 Nov 2018 16:41:19 +0100
Subject: [PATCH RFC 09/18] staging: vchiq_core: do not initialize
 semaphores twice
In-Reply-To: <1781917429.4071.1540759539282@email.ionos.de>
References: <20181026134813.7775-1-nsaenzjulienne@suse.de>
 <20181026134813.7775-10-nsaenzjulienne@suse.de>
 <1781917429.4071.1540759539282@email.ionos.de>
Message-ID: <ddef268b97543abc9de05842b92e1fc5f0134de8.camel@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,
thanks for spending the time reviewing the code. I took note of the
rest of comments.

On Sun, 2018-10-28 at 21:45 +0100, Stefan Wahren wrote:
> Hi Nicolas,
> 
> > Nicolas Saenz Julienne <nsaenzjulienne@suse.de> hat am 26. Oktober
> > 2018 um 15:48 geschrieben:
> > 
> > 
> > vchiq_init_state() initialises a series of semaphores to then call
> > remote_event_create() on the same semaphores, which initializes
> > them
> > again.
> 
> i would prefer to have all init stuff at one place in
> vchiq_init_state() and drop this ugliness from remote_event_create()
> instead. Is this possible?

As I'm sure you're aware of, REMOTE_EVENT_T is shared between the CPU
and VC4, which can't be expanded. And since storing a pointer is out of
question because of arm64, I can only think of storing an index to an
array of completions in the shared structure instead of the pointer
magic implemented right now. It would be a little more explicit. Then
we could completely decouple both initializations. I'm not sure if it's
similar to what you had in mind. 

On a semi-related topic, I'm curious to know why these shared
structures aren't set with the "__packed" preprocessor macro. Any
ideas? As fas as I've been told, in general, the compiler may reorder
or add unexpected padding to any structure. Which would be very bad in
this case.

Regards,
Nicolas
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181106/39a145f7/attachment.sig>
