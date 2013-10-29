From: wcohen@redhat.com (William Cohen)
Date: Tue, 29 Oct 2013 14:38:58 -0400
Subject: [PATCH] Make the 32-bit ARM get_user() and put_user() work for
 16-bit quantities
In-Reply-To: <20131029180414.GS16735@n2100.arm.linux.org.uk>
References: <1383065529-20001-1-git-send-email-wcohen@redhat.com>
 <20131029180414.GS16735@n2100.arm.linux.org.uk>
Message-ID: <527000C2.5000501@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/29/2013 02:04 PM, Russell King - ARM Linux wrote:
> On Tue, Oct 29, 2013 at 12:52:09PM -0400, William Cohen wrote:
>> The 32-bit ARM does not have instructions to perform 16-bit loads or
>> stores.  The __get_user_asm_half and __put_user_asm_half macros
>> sythesize those operations.  However, in most cases the pointers
>> passed into these macros are pointers to 16-bit types and the pointer
>> arithmetic will end up pointing at the next 16-bit quantity rather
>> than the second half (byte) of the 16-bit quantity.  The macros need
>> to explicitly typecast the pointers as pointers to 8-bit quantities to
>> make the pointer arithmetic work out properly.
> 
> NAK.
> 
> Nothing should be making use of these macros other than the other
> macros in that file; these are implementation specific helper macros.
> There, the address passed as __gu_addr and __pu_addr is an 'unsigned
> long' quantity, so there is no concern about pointer arithmetic; they
> do not take pointers.
> 

You are correct.  systemtap had had macros that were based on the arm uaccess.h macos, but they were missing the typecasts that __get_user_err and __put_user_err.  Thanks for pointing out my error.

-Will
