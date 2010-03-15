From: bgat@billgatliff.com (Bill Gatliff)
Date: Mon, 15 Mar 2010 08:05:25 -0500
Subject: QUERY: How to handle sharing of interrupt between different
	peripherals.
In-Reply-To: <4B9DD766.7010504@st.com>
References: <4B9DB99A.5040104@st.com>	<1b68c6791003142218q24fd8516id75d6964201da3f2@mail.gmail.com>
	<4B9DD766.7010504@st.com>
Message-ID: <4B9E3095.7040006@billgatliff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Viresh KUMAR wrote:
> On 3/15/2010 10:48 AM, jassi brar wrote:
>   
>> On Mon, Mar 15, 2010 at 1:37 PM, Viresh KUMAR <viresh.kumar@st.com> wrote:
>>     
>>> In our SOC (SPEArxxx), we have few peripherals which share common interrupt
>>> line.
>>>       
>> how about set_irq_chained_handler ?
>>     
>
> I think it is not for this purpose. Better to use IRQF_SHARED in normal
> request_irq. what do you say?
>   

Actually, set_irq_chained_handler() is designed specifically for
demultiplexing interrupt lines into independent descriptors, which is
exactly what you want here.  Otherwise, your drivers must know that
they're sharing interrupts, which is a platform-specific assumption. 
You don't want that.

Take a look at how AT91 is handing their GPIO.  Each bank has 32 pins,
but only one shared interrupt signal.  By demultiplexing that into 32
separate descriptors with set_irq_chained_handler(), drivers can all
uniformly call request_irq() when one of their interrupt sources is tied
to a GPIO--- same as if their interrupt source is a true IRQ line, an
internal source, or whatever.  That's what you want.

b.g.

-- 
Bill Gatliff
Embedded systems training and consulting
http://billgatliff.com
bgat at billgatliff.com
