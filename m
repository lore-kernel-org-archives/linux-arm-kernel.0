From: amelie.delaunay@st.com (Amelie DELAUNAY)
Date: Thu, 22 Feb 2018 15:13:30 +0000
Subject: [PATCH 0/6] Introduce STMicroelectronics MultiFunction eXpander
In-Reply-To: <CACRpkdZYnQC5BusLyK5aAcA2q0NmvHu=TaLhFCfu2M0bgBcjrQ@mail.gmail.com>
References: <1518100057-23234-1-git-send-email-amelie.delaunay@st.com>
 <CACRpkdZYnQC5BusLyK5aAcA2q0NmvHu=TaLhFCfu2M0bgBcjrQ@mail.gmail.com>
Message-ID: <276d5f97-55c2-406e-92c7-0d03c7f7a49d@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Thanks for your review on the whole series.

On 02/22/2018 02:06 PM, Linus Walleij wrote:
> Hi Amelie,
> 
> thanks a lot for your patches!
> 
> On Thu, Feb 8, 2018 at 3:27 PM, Amelie Delaunay <amelie.delaunay@st.com> wrote:
> 
>> This series adds support for STMicroelectronics MultiFunction eXpander
>> (ST MFX), used on some STM32 discovery and evaluation boards.
> 
> So I take it that the department creating the STMPE
> "ST MPE" or "ST Microelectronics MultiPurpose Expander"
> Now created a new set of circuits?
> 

ST MFX is based on a STM32L152 with a firmware offering features similar 
to the STMPE (GPIO and TS controller) but also IDD measurement to 
measure the power consumption of the MCU to which MFX is connected to.

> Can we first establish whether this new family is really so
> different from STMPE that it really needs a new driver in
> MFD and GPIO (and I guess pin control as well)?
> 

ST MFX is different from STMPE as far as the HW is completely different.
IDD is a new feature.
TS management is completely different.
GPIO management looks like but is also rather different.
ST MFX counts a first level of 8 interrupts (acked by writing in the ACK 
register), then a second level of 24 interrupts for GPIOs. GPIO IRQ can 
be triggered on low level, falling edge, high level, rising edge. GPIO 
IRQ have to be acked by writing in the GPI_ACK register, GPIO can be 
output open-drain with/without internal pull-up, output push-pull, input 
with pull-up/down, input floating or analog.

> I would be annoyed to see later that it is just a few bytes
> separating it from the STMPE, in that case I think it is
> better to just reuse/improve the good old stmpe driver
> and take it from there.
> 

Sure, but if it was a new STMPE variant, it would be called STMPE24xx or 
something like that (24 GPIOs maximum, 20 if IDD or TS is enabled, 16 if 
IDD and TS are enabled).

Regards,
Amelie

> Yours,
> Linus Walleij
> 
