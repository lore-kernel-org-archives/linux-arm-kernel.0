From: dhowells@redhat.com (David Howells)
Date: Fri, 25 Nov 2016 12:03:12 +0000
Subject: [PATCH 5/7] efi: Get the secure boot status [ver #3]
In-Reply-To: <CAKv+Gu_JxNLDjaK5jGbX9ACzM0uHJYMOFx7XDo4t7DtBMtFRGA@mail.gmail.com>
References: <CAKv+Gu_JxNLDjaK5jGbX9ACzM0uHJYMOFx7XDo4t7DtBMtFRGA@mail.gmail.com>
 <147990561294.7576.6464430479448167484.stgit@warthog.procyon.org.uk>
 <147990565051.7576.9673287945782426886.stgit@warthog.procyon.org.uk>
 <1480016487.2444.18.camel@HansenPartnership.com>
 <15173.1480066220@warthog.procyon.org.uk>
Message-ID: <16661.1480075392@warthog.procyon.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

How about the attached additional patch?  Should I be checking the UEFI
version number if such is available?

David
---
commit 981110f45ba73798875af7639d0328dc2d6f9919
Author: David Howells <dhowells@redhat.com>
Date:   Fri Nov 25 11:52:05 2016 +0000

    efi: Handle secure boot from UEFI-2.6
    
    UEFI-2.6 adds a new variable, DeployedMode.  If it exists, this must be 1
    to engage lockdown mode.
    
    Reported-by: James Bottomley <James.Bottomley@HansenPartnership.com>
    Signed-off-by: David Howells <dhowells@redhat.com>

diff --git a/drivers/firmware/efi/libstub/secureboot.c b/drivers/firmware/efi/libstub/secureboot.c
index ca643eba5a4b..4c3bddef4fb3 100644
--- a/drivers/firmware/efi/libstub/secureboot.c
+++ b/drivers/firmware/efi/libstub/secureboot.c
@@ -22,6 +22,9 @@ static const efi_char16_t const efi_SecureBoot_name[] = {
 static const efi_char16_t const efi_SetupMode_name[] = {
 	'S', 'e', 't', 'u', 'p', 'M', 'o', 'd', 'e', 0
 };
+static const efi_char16_t const efi_DeployedMode_name[] = {
+	'D', 'e', 'p', 'l', 'o', 'y', 'e', 'd', 'M', 'o', 'd', 'e', 0
+};
 
 /* SHIM variables */
 static const efi_guid_t shim_guid = EFI_SHIM_LOCK_GUID;
@@ -62,6 +65,16 @@ int efi_get_secureboot(efi_system_table_t *sys_table_arg)
 	if (val == 1)
 		return 0;
 
+	status = get_efi_var(efi_DeployedMode_name, &efi_variable_guid,
+			     NULL, &size, &val);
+	if (status != EFI_NOT_FOUND) {
+		if (status != EFI_SUCCESS)
+			goto out_efi_err;
+
+		if (val == 1)
+			return 0;
+	}
+
 	/* See if a user has put shim into insecure mode.  If so, and if the
 	 * variable doesn't have the runtime attribute set, we might as well
 	 * honor that.
