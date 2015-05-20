From: javier@javigon.com (=?utf-8?Q?Javier_Gonz=C3=A1lez?=)
Date: Wed, 20 May 2015 16:11:05 +0200
Subject: [PATCH V3 2/2] tee: add OP-TEE driver
In-Reply-To: <20150520121648.GA9819@ermac>
References: <1431671667-11219-1-git-send-email-jens.wiklander@linaro.org>
 <1431671667-11219-3-git-send-email-jens.wiklander@linaro.org>
 <20150518131850.GA7064@leverpostej> <20150520121648.GA9819@ermac>
Message-ID: <887DE856-552A-4A21-8CC7-CFB9B80033E4@javigon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
Just for completeness,

> On 20 May 2015, at 14:16, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> 
> Hi,
> 
> On Mon, May 18, 2015 at 02:18:50PM +0100, Mark Rutland wrote:
>> Hi,
>> 
>> On Fri, May 15, 2015 at 07:34:27AM +0100, Jens Wiklander wrote:
> 
[?]

>> 
>> I'm also very concerned that the interface exposed to userspace is
>> hideously low-level. Surely we'd expect kernel-side drivers to be doing
>> the bulk of direct communication to the OP-TEE instance? In the lack of
>> a provided rationale I don't see why the current messaging interface
>> would make sense.
> The kernel-side does all the direct communication since there's where
> the SMC is done, but one level above most of the communication is
> terminated in user space. Loading of Trusted Applications and other file
> system access is done in by a helper process in user space,
> tee-supplicant. A large part of the OP-TEE message protocol is
> transparent to the kernel.
> 
> We're trying to not exclude any TEE implementation by having this low
> level TEE_IOC_CMD instead of a high level interface. The problem with
> the different TEEs is that they are designed differently and we haven't
> been able to find a high level interface that suits all. Applications
> aren't expected to use TEE_IOC_CMD directly, instead there's supposed to
> be a client lib wich wraps the kernel interface and provides a higher
> level interface, for instance a Global Platform Client API in the case
> of a GP TEE.
> 
> For OP-TEE we're using the same protocol all the way down to user space,
> the advantage is that it's only one protocol to keep track of and we
> don't need to translate the entire message (we do need to copy it,
> excluding the payload) each time the message is passed to the next
> memory space. In the presence of a hypervisor we have
> user space -> kernel -> hypervisor -> secure world
> Unfortunately some fields has a different meaning in user space and
> kernel space. I'll address this in the documentation.
> 
> The OP-TEE helper process, tee-supplicant, is specific to only OP-TEE.
> Other TEEs uses helper processes too, but what they do depend on the
> design of the TEE. As a consequence more or less all TEEs needs
> something specific for that particular TEE in user space to be fully
> functional.
> 
> To summarize, the current assumption is that all TEEs can't use the same
> high level interface. Instead we need to provide a way for each TEE to
> have their own low level interface which should be wrapped in a user
> space library to provide a more reasonable interface to the client
> application.
> 
> 

This design aims to be TEE agnostic.

As Jens mentioned, user space applications are supposed to use client-side
API?s (e.g., Global Platform). It is convenient that these APIs reside in user
space together with the wrapper using the kernel TEE interface. Note that
GP?s APIs have changed much since they were first released. It would be
a lot of work to keep them updated in the kernel and we would eventually
run into the issue that they are not backwards compatible, thus making  user
space applications break.

Also, we want to eventually support kernel submodules to use the TEE subsystem.
In this case, having a simple in-kernel interface makes things easier. Again,
having a rich API such as GP in the kernel would not add any value.

[?]

Javier.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 842 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150520/12cbfa54/attachment.sig>
