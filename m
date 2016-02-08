From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Sun, 7 Feb 2016 22:51:42 -0800
Subject: [PATCH v7 0/4] generic TEE subsystem
In-Reply-To: <1454318140-7962-1-git-send-email-jens.wiklander@linaro.org>
References: <1454318140-7962-1-git-send-email-jens.wiklander@linaro.org>
Message-ID: <20160208065142.GA23170@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 01, 2016 at 10:15:36AM +0100, Jens Wiklander wrote:
> Hi,
> 
> This patch set introduces a generic TEE subsystem. The TEE subsystem will
> contain drivers for various TEE implementations. A TEE (Trusted Execution
> Environment) is a trusted OS running in some secure environment, for
> example, TrustZone on ARM CPUs, or a separate secure co-processor etc.
> 
> Regarding use cases, TrustZone has traditionally been used for
> offloading secure tasks to the secure world. Examples include: 
> - Secure key handling where the OS may or may not have direct access to key
>   material.
> - E-commerce and payment technologies. Credentials, credit card numbers etc
>   could be stored in a more secure environment.
> - Trusted User Interface (TUI) to ensure that no-one can snoop PIN-codes
>   etc.
> - Secure boot to ensure that loaded binaries haven?t been tampered with.
>   It?s not strictly needed for secure boot, but you could enhance security
>   by leveraging a TEE during boot.
> - Digital Rights Management (DRM), the studios provides content with
>   different resolution depending on the security of the device. Higher
>   security means higher resolution.
> 
> A TEE could also be used in existing and new technologies. For example IMA
> (Integrity Measurement Architecture) which has been in the kernel for quite
> a while. Today you can enhance security by using a TPM-chip to sign the IMA
> measurement list. This is something that you also could do by leveraging a
> TEE.
> 
> Another example could be in 2-factor authentication which is becoming
> increasingly more important. FIDO (https://fidoalliance.org) for example
> are using public key cryptography in their 2-factor authentication standard
> (U2F). With FIDO, a private and public key pair will be generated for every
> site you visit and the private key should never leave the local device.
> This is an example where you could use secure storage in a TEE for the
> private key.
> 
> Today you will find a quite a few different out of tree implementations of
> TEE drivers which tends to fragment the TEE ecosystem and development. We
> think it would be a good idea to have a generic TEE driver integrated in
> the kernel which would serve as a base for several different TEE solutions,
> no matter if they are on-chip like TrustZone or if they are on a separate
> crypto co-processor.
> 
> To develop this TEE subsystem we have been using the open source TEE called
> OP-TEE (https://github.com/OP-TEE/optee_os) and therefore this would be the
> first TEE solution supported by this new subsystem. OP-TEE is a
> GlobalPlatform compliant TEE, however this TEE subsystem is not limited to
> only GlobalPlatform TEEs, instead we have tried to design it so that it
> should work with other TEE solutions also.
> 
> "tee: generic TEE subsystem" brings in the generic TEE subsystem which
> helps when writing a driver for a specific TEE, for example, OP-TEE.
> 
> "tee: add OP-TEE driver" is an OP-TEE driver which uses the subsystem to do
> its work.
> 
> This patch set has been prepared in cooperation with Javier Gonz?lez who
> proposed "Generic TrustZone Driver in Linux Kernel" patches 28 Nov 2014,
> https://lwn.net/Articles/623380/ . We've since then changed the scope to
> TEE instead of TrustZone.
> 
> We have discussed the design on tee-dev at lists.linaro.org (archive at
> https://lists.linaro.org/pipermail/tee-dev/) with people from other
> companies, including Valentin Manea <valentin.manea@huawei.com>,
> Emmanuel MICHEL <emmanuel.michel@st.com>,
> Jean-michel DELORME <jean-michel.delorme@st.com>,
> and Joakim Bech <joakim.bech@linaro.org>. Our main concern has been to
> agree on something that is generic enough to support many different
> TEEs while still keeping the interface together.
> 
> v7:
> * Rebased on v4.5-rc2
> * Moved the ARM SMC Calling Convention support into a separate patch
>   set, which is now merged

Given this breaks the build on x86-64, I can't take this :(

Please fix up and do a basic bit of build testing...
