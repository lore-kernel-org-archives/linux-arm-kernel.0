From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 9 Jun 2017 23:30:49 +0200
Subject: Drivers taking different actions depending on sleep state
In-Reply-To: <0181d683-511e-1ff6-3855-e00849863e74@free.fr>
References: <9dc7b7f4-e47d-59f3-3b51-52e0aefd2487@free.fr>
 <0181d683-511e-1ff6-3855-e00849863e74@free.fr>
Message-ID: <20170609213049.GA28596@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2017-06-09 18:27:45, Mason wrote:
> On 09/06/2017 17:20, Mason wrote:
> 
> > Currently my platform's "mem" is a true suspend-to-RAM trigger,
> > where drivers are supposed to save their state (register values
> > will be lost), then Linux hands control over to firmware which
> > enables RAM self-refresh and powers the chip down. When the system
> > resumes, drivers restore their state from their copy in memory.
> > 
> > One driver is responsible for loading/unloading microcode running
> > on the DSPs. This operation is required only when powering down
> > the chip, but it should be avoided for "low-latency" sleeps.
> > 
> > The problem is that, if I understand correctly, drivers have no way
> > of knowing which sleep state is being entered/exited?
> > 
> > How can I have the microcode driver take different decisions
> > based on the sleep state?
> 
> FWIW, here's a transcript of a parallel discussion on #armlinux


Well... question "does my chip lose state during standby/mem on _this_
machine" is more complex then "is it standby or mem", right?

You should really ask the regulator framework, not core code.

> Mason385	javier__: there's some authentication required when S2R is involved (from the firmware)
> javier__	Mason385: ah, Ok. I just asked because if it was the latter, the regulator subsystem has infrastructure to keep the regulators on during S2R
> Mason385	javier__: OK so there's two issues. We are required to
> re-authenticate microcode when resuming from S2R (because someone
> "may" have tampered with the contents) and on suspend, power is cut
> to the DSPs and they lose context

I'm not sure what you are developing. Someone also "may" have modified
the microcode while you were running. Someone also "may" have modified
the kernel in RAM. Not sure what you are developing, but protecting
against attacker with direct hardware access is impossible and not
welcome.

Best regards,
								Pavel
								
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170609/642ebb76/attachment-0001.sig>
